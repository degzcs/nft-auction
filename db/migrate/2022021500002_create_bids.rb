class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.string :amount
      t.integer :user_id
      t.integer :auction_id
    end
  end
end
