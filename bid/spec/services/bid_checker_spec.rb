describe BidChecker do
  subject do
    BidChecker.new(
      auction_id: auction_id,
      user_id: user_id,
      amount: amount
    )
  end

  let(:auction_id) { 1 }
  let(:user_id){ 1 }
  let(:amount) { 200.0 }

  context 'valid bid' do
    it 'should return a valid bid' do
      subject.call
      expect(subject.success?).to be true
    end
  end

  context 'invalid bid' do
    context 'the amout is less than the before amout in the auction' do
      let(:amount) { 100.0 }
      let(:previous_amount) { 200.0 }
      let!(:previous_bid) do
        Bid.create(
          user_id: user_id,
          auction_id: auction_id,
          amount: previous_amount
        )
      end

      it 'should return an errors messages' do
        subject.call
        expect(subject.success?).to be false
        expect(subject.errors[0]).to eq 'You have to go higher!'
      end
    end

    context 'the current user was the last bidder' do
      let(:previous_amount) { 1.0 }
      let!(:previous_bid) do
        Bid.create(
          user_id: user_id,
          auction_id: auction_id,
          amount: previous_amount
        )
      end

      it 'should return an errors messages' do
        subject.call
        expect(subject.success?).to be false
        expect(subject.errors[0]).to eq 'You cannot issue bids consecutively'
      end
    end
    context 'the amount is a invalid number' do
      let(:amount) { 'invalid' }

      it 'should return an errors messages' do
        subject.call
        expect(subject.success?).to be false
        expect(subject.errors[0]).to eq 'Amount is not a number'
      end
    end
  end
end
