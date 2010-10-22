class GithubUser < ActiveRecord::Base
  has_friendly_id :username, :use_slug=>true
end
