# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101022135822) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "lastfm_url"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["cached_slug"], :name => "index_artists_on_cached_slug"
  add_index "artists", ["name"], :name => "index_artists_on_name"

  create_table "artists_lastfm_users", :id => false, :force => true do |t|
    t.integer "artist_id"
    t.integer "lastfm_user_id"
  end

  add_index "artists_lastfm_users", ["artist_id"], :name => "index_artists_lastfm_users_on_artist_id"
  add_index "artists_lastfm_users", ["lastfm_user_id"], :name => "index_artists_lastfm_users_on_lastfm_user_id"

  create_table "artists_tags", :id => false, :force => true do |t|
    t.integer "artist_id"
    t.integer "tag_id"
  end

  add_index "artists_tags", ["artist_id"], :name => "index_artists_tags_on_artist_id"
  add_index "artists_tags", ["tag_id"], :name => "index_artists_tags_on_tag_id"

  create_table "github_users", :force => true do |t|
    t.string   "username"
    t.integer  "followers"
    t.string   "cached_slug"
    t.string   "real_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "github_users", ["cached_slug"], :name => "index_github_users_on_cached_slug"
  add_index "github_users", ["username"], :name => "index_github_users_on_username"

  create_table "gitub_users_languages", :id => false, :force => true do |t|
    t.integer "github_user_id"
    t.integer "language_id"
  end

  add_index "gitub_users_languages", ["github_user_id"], :name => "index_gitub_users_languages_on_github_user_id"
  add_index "gitub_users_languages", ["language_id"], :name => "index_gitub_users_languages_on_language_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lastfm_users", :force => true do |t|
    t.string   "username"
    t.string   "country"
    t.string   "real_name"
    t.integer  "age"
    t.boolean  "verified"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lastfm_users", ["cached_slug"], :name => "index_lastfm_users_on_cached_slug"
  add_index "lastfm_users", ["username"], :name => "index_lastfm_users_on_username"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["cached_slug"], :name => "index_tags_on_cached_slug"
  add_index "tags", ["name"], :name => "index_tags_on_name"

end
