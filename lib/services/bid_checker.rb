class BidChecker
  attr_reader :auction_id, :user_id, :amount, :bid, :errors

  def initialize(auction_id:, user_id:, amount:)
    @auction_id = auction_id
    @user_id = user_id
    @amount = amount
    @errors = []
  end

  def call
    check_user_exists
    check_amount_rule
    check_last_bidder_rule
    check_model_rules
  rescue => e
    errors >> e.message
  end

  def success?
    errors == []
  end

  private

  def check_user_exists
    errors << 'User does not exist' unless User.exists?(user_id)
  end

  def check_model_rules
    @bid = Bid.new(
      amount: amount,
      user_id: user_id,
      auction_id: auction_id
    )
    errors << bid.errors.full_messages[0] unless bid.valid?
  end

  def check_amount_rule
    errors << 'You have to go higher!' if last_amount && last_amount > amount
  end

  def check_last_bidder_rule
    errors << 'You cannot issue bids consecutively' if last_user_id == user_id
  end

  def last_bid
    @last_bid ||= Bid.last_for_auction(auction_id).last
  end

  def last_amount
    last_bid&.amount
  end

  def last_user_id
    last_bid&.user_id
  end
end
