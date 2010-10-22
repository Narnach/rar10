class Tag < ActiveRecord::Base
  has_friendly_id :name, :use_slug=>true
  has_and_belongs_to_many :artists
  
  def self.most_populair_genres(amount=10)
    tags=Hash.new
    Tag.all.each do |t|
      tags[t.name]=t.artists.count
    end
    tags=tags.sort_by(&:last).reverse[0...amount]
  end
  
  def self.most_populair_genres_for_language_id(lang=2)
    GithubUsers.find(:all,:conditions=>{:language_id=>lang}, :include=>:artists).map{|u|u.artist.map(&:genre)}
    
  end
end
