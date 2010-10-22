require 'scrobbler'
require 'fileutils'
require 'yaml'

FileUtils.mkdir_p "data/artists"
FileUtils.mkdir_p "data/users"

users = %w[smeevil narnach].map{|user| Scrobbler::User.new user}
artists = Array.new
tags = Array.new

users.each do |user|
  user_artists_file = "data/users/#{user}_artists.yml"
  if File.exist?(user_artists_file)
    YAML.from_file(user_artists_file)
  else
    found_user_artists = user.top_artists
    File.open(user_artists_file,"w") {|f| f.write found_user_artists.to_yaml}
    artists << found_user_artists
  end
end

artists.flatten.uniq.each do |artist|
  artist_tags_file = "data/artists/#{artist}_tags.yml"
  
  if File.exist?(artist_tags_file)
    YAML.from_file(artist_tags_file)
  else
    found_artist_tags = artist.top_tags
    File.open(artist_tags_file,"w") {|f| f.write found_artist_tags.to_yaml}
    artists << found_artist_tags
    tags << found_artist_tags
  end
end

p artists
p tags