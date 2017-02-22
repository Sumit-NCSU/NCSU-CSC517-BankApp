# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170221002902) do

  create_table "account_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_account_requests_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string   "account_number"
    t.string   "status"
    t.decimal  "balance",        precision: 7, scale: 2, default: "0.0"
    t.integer  "user_id"
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer  "friend1_id"
    t.integer  "friend2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.string   "txn_type"
    t.decimal  "amount",          precision: 7, scale: 2
    t.integer  "form_account_id"
    t.integer  "to_account_id"
    t.datetime "start_date"
    t.datetime "effective_date"
    t.string   "status"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["form_account_id"], name: "index_transactions_on_form_account_id"
    t.index ["to_account_id"], name: "index_transactions_on_to_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.boolean  "is_admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
