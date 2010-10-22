class CreateLastfmUsers < ActiveRecord::Migration
  def self.up
    create_table :lastfm_users do |t|
      t.string :username
      t.string :country
      t.string :real_name
      t.integer :age
      t.boolean :verified
      t.string :cached_slug

      t.timestamps
    end
    add_index :lastfm_users, :username
    add_index :lastfm_users, :cached_slug
  end

  def self.down
    drop_table :lastfm_users
  end
end
