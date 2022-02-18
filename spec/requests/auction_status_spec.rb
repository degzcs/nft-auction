describe 'Auction status', type: :request do
  let(:app) { Api.new  }
  let(:auction_id) { 1 }
  let(:user){ User.create(username: 'test', address: 'test') }
  let(:user2){ User.create(username: 'test2', address: 'test') }
  let(:token) do
    ManageJWT.instance.encode(user_id: user.id)
  end
  let(:url) do
    "/auction/#{auction_id}/check-status"
  end

  let(:response) do
    header 'ACCESS_TOKEN', token
    get url
  end

  let(:highest_amount_user2 ){ 50 }
  let(:highest_amount_user1) { 40 }

  before :each do
    Bid.create(
      user_id: user.id,
      auction_id: auction_id,
      amount: 10
    )
    Bid.create(
      user_id: 2_000,
      auction_id: auction_id,
      amount: 20
    )
    Bid.create(
      user_id: user2.id,
      auction_id: auction_id,
      amount: 30
    )
    Bid.create(
      user_id: user.id,
      auction_id: auction_id,
      amount: highest_amount_user1
    )
    Bid.create(
      user_id: user2.id,
      auction_id: auction_id,
      amount: highest_amount_user2
    )
  end

  context 'authorized user' do
    context 'winner is not current user' do
      let(:expected_response) do
        {
          "current_bid" => {
            "amount" => highest_amount_user1
          },
          "highest_bid" => {
            "amount" => highest_amount_user2,
            "owner" => false
          }
        }
      end

      it 'returns the current auction status' do
        json_res = JSON.parse(response.body)
        expect(json_res).to include expected_response
      end
    end

    context 'winner is the current user' do
      let(:token) do
        ManageJWT.instance.encode(user_id: user2.id)
      end
      let(:expected_response) do
        {
          "current_bid" => {
            "amount" => highest_amount_user2
          },
          "highest_bid" => {
            "amount" => highest_amount_user2,
            "owner" => true

          }
        }
      end

      it 'returns the current auction status' do
        json_res = JSON.parse(response.body)
        expect(json_res).to include expected_response
      end
    end
  end

  context 'No-authorized user' do
    let(:token) { nil }

    let(:expected_response) do
      {
        "highest_bid" => {
          "amount" => highest_amount_user2,
          "owner" => false
        }
      }
    end

    it 'returns the current auction status' do
      json_res = JSON.parse(response.body)
      expect(json_res).to include expected_response
    end
  end
end
