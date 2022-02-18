class Api < Sinatra::Base

  helpers do
    def authorized?
      token = request.fetch_header('HTTP_ACCESS_TOKEN')
      @payload, @header = ManageJWT.instance.decode(new_token: token)

    rescue => e
      false
    end

    def user_id
      @payload['user_id']
    end
  end

  post '/auction/:auction_id/registration' do
    auction_id = params[:auction_id]
    service = UserRegistration.new(
      username: params[:username],
      address: params[:address]
    )

    if service.call && service.success?
      # TODO put this in the sinatra settings
      token = ManageJWT.instance.encode(user_id: service.user.id)
      headers['access_token'] = token
      [200, 'OK']
    else
      [400, service.errors.to_json]
    end
  end

  post '/auction/:auction_id/bid' do
    return [400, 'Sorry you are not authorized'] unless authorized?

    auction_id = params[:auction_id]

    service = BidChecker.new(
      auction_id: auction_id,
      user_id: user_id,
      amount: params[:amount]
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
    auction_id = params[:auction_id]

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
