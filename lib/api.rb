class Api < Sinatra::Base

  helpers do
    def authorized?
      token = request.fetch_header('HTTP_ACCESS_TOKEN')
      @payload, @header = ManageJWT.instance.decode(new_token: token)

    rescue => e
      false
    end

    def auction_id
      params[:auction_id]
    end

    def user_id
      @payload['user_id']
    end

    # NOTE: workarround to get all params
    def aparams
      if ENV['RACK_ENV'] == 'test'
        @aparams ||= params
      else
        @aparams ||= params.merge(JSON.parse(request.body.read))
      end
    end
  end

  post '/auction/:auction_id/registration' do
    service = UserRegistration.new(
      username: aparams[:username],
      address: aparams[:address],
      auction_id: aparams[:auction_id]
    )

    service.call
    if service.success?
      token = ManageJWT.instance.encode(user_id: service.user.id)
      puts token
      headers['access_token'] = token
      [200, "User registered to auction #{auction_id}".to_json]
    else
      [400, service.errors.to_json]
    end
  end

  post '/auction/:auction_id/bid' do
    return [400, 'Sorry you are not authorized'] unless authorized?

    service = BidChecker.new(
      auction_id: auction_id,
      user_id: user_id,
      amount: aparams[:amount]
    )
    service.call

    if  service.success?
      if service.bid.save
        [200, service.bid.attributes.to_json ]
      else
        [400, service.bid.errors.full_message.to_json]
      end
    else
      [400, service.errors.to_json]
    end

  end

  get '/auction/:auction_id/check-status' do
    highest_bid = Bid.highest_for_auction(auction_id).first

    data = if authorized?
             current_bid_amount = Bid.highest_for_user(auction_id, user_id)
             owner = user_id.equal?(highest_bid.user_id)

             AuctionPresenter.new.status(
               current_bid_amount: current_bid_amount,
               highest_bid_amount: highest_bid.amount,
               owner: owner
             )
           else
             AuctionPresenter.new.status(
               highest_bid_amount: highest_bid.amount
             )
           end

    [200, data.to_json]
  end
end
