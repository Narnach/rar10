class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :image_url
      t.string :lastfm_url
      t.string :cached_slug

      t.timestamps
    end
    add_index :artists, :cached_slug
    add_index :artists, :name

    create_table :artists_lastfm_users, :id=>false, :force=>true do |t|
      t.integer :artist_id
      t.integer :lastfm_user_id
    end
    add_index :artists_lastfm_users, :artist_id
    add_index :artists_lastfm_users, :lastfm_user_id
  end

  def self.down
    drop_table :artists_lastfm_users
    drop_table :artists
  end
end
