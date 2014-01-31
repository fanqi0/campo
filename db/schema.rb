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

ActiveRecord::Schema.define(version: 20140130122905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "name"
    t.boolean  "read",         default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["subject_id", "subject_type"], name: "index_notifications_on_subject_id_and_subject_type", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "post_likes", id: false, force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
  end

  add_index "post_likes", ["user_id", "post_id"], name: "index_post_likes_on_user_id_and_post_id", unique: true, using: :btree

  create_table "topics", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.float    "hot",            default: 0.0
    t.integer  "comments_count", default: 0
    t.boolean  "deleted",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "email_lower"
    t.string   "username"
    t.string   "username_lower"
    t.string   "password_digest"
    t.text     "bio"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
