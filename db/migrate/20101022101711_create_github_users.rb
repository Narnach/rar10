class CreateGithubUsers < ActiveRecord::Migration
  def self.up
    create_table :github_users do |t|
      t.string :username
      t.integer :followers
      t.integer :forks
      t.string :cached_slug

      t.timestamps
    end
    add_index :github_users, :username
    add_index :github_users, :cached_slug
  end

  def self.down
    drop_table :github_users
  end
end
