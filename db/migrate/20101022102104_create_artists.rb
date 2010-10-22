class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :image_url
      t.string :lastfm_url

      t.timestamps
    end

    create_table :artists_lastfm_users, :id=>false, :force=>true do |t|
      t.integer :artist_id
      t.integer :lastfm_user_id
    end
  end

  def self.down
    drop_table :artists_lastfm_users
    drop_table :artists
  end
end
