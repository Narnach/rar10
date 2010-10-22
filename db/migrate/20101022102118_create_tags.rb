class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :artists_tags, :id=>false, :force=>true do |t|
      t.integer :artist_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :tags   
    drop_table :artists_tags
  end
end
