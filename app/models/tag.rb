class Tag < ActiveRecord::Base
  has_friendly_id :name, :use_slug=>true
  has_and_belongs_to_many :artists
end
