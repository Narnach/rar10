class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name
      t.string :cached_slug

      t.timestamps
    end
    add_index :tags, :name
    add_index :tags, :cached_slug
    
    create_table :artists_tags, :id=>false, :force=>true do |t|
      t.integer :artist_id
      t.integer :tag_id
    end
    add_index :artists_tags, :artist_id
    add_index :artists_tags, :tag_id
  end

  def self.down
    drop_table :tags   
    drop_table :artists_tags
  end
end
