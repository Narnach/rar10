class CreateGithubUsers < ActiveRecord::Migration
  def self.up
    create_table :github_users do |t|
      t.string :username
      t.integer :followers
      t.integer :forks

      t.timestamps
    end
  end

  def self.down
    drop_table :github_users
  end
end
