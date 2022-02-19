class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|
      t.float :amount
      t.integer :user_id
      t.integer :auction_id
      t.timestamps null: false
    end
  end
end
