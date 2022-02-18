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

    # NOTE: workarround to get all params
    def aparams
      if ENV['RACK_ENV'] == 'test'
        @aparams ||= params
      else
        @aparams ||= params.merge(JSON.parse(request.body.read))
      end
    end
  end

  post '/registration' do
    service = UserRegistration.new(
      username: aparams[:username],
      address: aparams[:address]
    )

    service.call
    if service.success?
      token = ManageJWT.instance.encode(user_id: service.user.id)
      headers['access_token'] = token
      [200, "User was registered".to_json]
    else
      [400, service.errors.to_json]
    end
  end
end
