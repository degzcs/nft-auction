describe 'Bid', type: :request do
  let(:app) { Api.new  }
  let(:auction_id) { 1 }
  let(:amount) { 200.0 }
  let(:user){ User.create(username: 'test', address: 'test') }
  let(:token) do
    ManageJWT.instance.encode(user_id: user.id)
  end
  let(:params) do
    {
      amount: amount,
    }
  end
  let(:url) do
    "/auction/#{auction_id}/bid"
  end

  let(:response) do
    header 'ACCESS_TOKEN', token
    post url, params
  end

  context 'happy path' do
    it 'should create a BID' do
      json_res = JSON.parse(response.body)
      expect(json_res['id']).to be_present
    end
  end

  context 'not authorized user' do
    context 'wrong token' do
      let(:response) do
        header 'ACCESS_TOKEN', 'wrong-token'
        post url, params
      end

      it 'returns an authorized message' do
        expect(response.body).to eq 'Sorry you are not authorized'
      end
    end
    context 'none token' do
      let(:response) do
        post url, params
      end

      it 'returns an authorized message' do
        expect(response.body).to eq 'Sorry you are not authorized'
      end
    end
  end

  context 'invalid parameter' do
    let(:amount) { 'invalid-amount' }

    it 'should return the error message' do
      json_res = JSON.parse(response.body)
      expect(json_res[0])
        .to eq 'Amount is not a number'
    end
  end
end
