# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150721190450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tracks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "soundcloud_id"
    t.string   "title"
    t.text     "description"
    t.string   "genre"
    t.string   "license"
    t.string   "permalink_url"
    t.string   "artwork_url"
    t.string   "waveform_url"
    t.string   "stream_url"
    t.string   "purchase_url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "access_token"
    t.string   "password_digest"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "soundcloud_token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.string   "artist_name"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "soundcloud_id"
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
