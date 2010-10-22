class LastfmUser < ActiveRecord::Base
  has_friendly_id :username, :use_slug=>true
  has_and_belongs_to_many :artists
end
