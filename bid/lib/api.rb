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
end
