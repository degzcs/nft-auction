describe Bid do
  let(:auction_id) { nil }
  context 'scopes' do
    let(:highest_amount ){ 50 }
    before :each do
        Bid.create(
          user_id: 1,
          auction_id: auction_id,
          amount: 10
        )
        Bid.create(
          user_id: 2,
          auction_id: auction_id,
          amount: highest_amount
        )
        Bid.create(
          user_id: 3,
          auction_id: auction_id,
          amount: 40
        )
    end

    context 'given a auction' do
      let(:auction_id) { 1 }
      context 'get the max BID' do
        it 'should return the highest bid' do
          res = Bid.highest_for_auction(auction_id).first
          amount, user_id = res.amount, res.user_id
          expect(amount).to eq highest_amount
        end
      end
      context 'order bids' do
        it 'should return the lastest bid' do
          last_bid = Bid.ordered_bids_for(auction_id, 1).last
          expect(last_bid.amount).to eq 10
        end
      end
    end
  end
end
