# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022021500002) do
  create_table "auctions", force: :cascade do |t|
    t.string "asset"
  end

  create_table "bids", force: :cascade do |t|
    t.string "amount"
    t.integer "user_id"
    t.integer "auction_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "address"
    t.string "password_digest"
  end

end
