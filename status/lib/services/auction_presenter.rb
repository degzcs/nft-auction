class AuctionPresenter
  def status(current_bid_amount: nil, highest_bid_amount:, owner: false)
     data = {
        highest_bid: {
          amount: highest_bid_amount,
          owner: owner
        }
      }

    if current_bid_amount
      extra_data = {
        current_bid: {
          amount: current_bid_amount
        }
      }
      data.merge!(extra_data)
    end

    data
  end
end
