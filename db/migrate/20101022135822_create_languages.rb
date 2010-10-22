class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :gitub_users_languages, :id=>false, :force=>true do |t|
      t.integer :github_user_id
      t.integer :language_id
    end
    add_index :gitub_users_languages, :github_user_id
    add_index :gitub_users_languages, :language_id
  end

  def self.down
    drop_table :languages
  end
end
