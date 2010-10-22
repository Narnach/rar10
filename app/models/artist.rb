class Artist < ActiveRecord::Base
  has_friendly_id :name, :use_slug=>true
  has_and_belongs_to_many :tags, :uniq=>true
  has_and_belongs_to_many :lastfm_users, :uniq=>true
end
