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
