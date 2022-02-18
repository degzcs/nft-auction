describe 'Registration', type: :request do
  let(:app) { Api.new  }
  let(:params) do
    {
      username: username,
      address: address }
  end
  let(:response) { post '/registration', params }

  context 'happy path' do
    let(:username) { 'AlanBritho' }
    let(:address) { '0xde709f2102306220921060314715629080e2fb77' }

    it 'should return a JWT' do
      expect(response.headers['access_token']).to be_present
    end
  end

  context 'missing parameters' do
    let(:username) { nil }
    let(:address) { nil }

    it 'should return the error message' do
      json_res = JSON.parse(response.body)
      expect(json_res[0])
        .to eq "Validation failed: Password can't be blank, Username can't be blank, Address can't be blank"
      expect(response.headers['access_token']).not_to be_present
    end
  end
end
