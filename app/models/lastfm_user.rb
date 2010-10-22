class LastfmUser < ActiveRecord::Base
  has_friendly_id :username, :use_slug=>true
  has_and_belongs_to_many :artists
  named_scope :verified, :conditions => {:verified=>true}
  
  def tags(amount=5)
    self.artists(:include=>:tags).map{|a|a.tags.map(&:name)}.flatten.group_by{|t|t}.map{|t,ary|[t, ary.size]}.sort_by(&:last).reverse[0...amount]
  end
end
