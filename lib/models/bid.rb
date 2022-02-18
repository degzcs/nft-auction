class Bid < ActiveRecord::Base
  validates_presence_of :amount
  validates_numericality_of :amount

  belongs_to :user
  belongs_to :auction

  scope :ordered_bids_for, ->(auction_id, user_id) do
    where(auction_id: auction_id, user_id: user_id).order(:created_at)
  end
  scope :last_for_auction, ->(auction_id) {where(auction_id: auction_id).order(:created_at)}
  scope :highest_for_auction, ->(auction_id) do
    where(auction_id: auction_id).select("MAX('bids'.'amount') as amount, user_id")
  end
  scope :highest_for_user, ->(auction_id, user_id) do
    where(auction_id: auction_id, user_id: user_id).maximum(:amount) || 0
  end

end
