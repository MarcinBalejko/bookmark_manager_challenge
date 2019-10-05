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

ActiveRecord::Schema.define(version: 2019_10_05_125920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", id: :serial, force: :cascade do |t|
    t.string "url", limit: 60
    t.string "title", limit: 60
    t.integer "owner_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "text", limit: 240
    t.integer "bookmark_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "content", limit: 60
    t.integer "bookmark_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 60
    t.string "password", limit: 140
  end

  add_foreign_key "bookmarks", "users", column: "owner_id", name: "bookmarks_owner_id_fkey"
  add_foreign_key "comments", "bookmarks", name: "comments_bookmark_id_fkey"
  add_foreign_key "tags", "bookmarks", name: "tags_bookmark_id_fkey"
end
