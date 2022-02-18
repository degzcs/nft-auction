class CreateAuctions < ActiveRecord::Migration[6.1]
  def change
    create_table :auctions do |t|
      t.string :asset
      t.timestamps null: false
    end
  end
end
