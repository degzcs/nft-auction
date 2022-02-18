class Api < Sinatra::Base

  post '/auction/registration' do
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

  post '/auction/bid' do
  end

  get '/auction/check-status' do
  end
end
