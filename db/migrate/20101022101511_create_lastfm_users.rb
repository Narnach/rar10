class CreateLastfmUsers < ActiveRecord::Migration
  def self.up
    create_table :lastfm_users do |t|
      t.string :username
      t.string :country
      t.string :real_name
      t.integer :age
      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :lastfm_users
  end
end
