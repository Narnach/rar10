require 'scrobbler'
require 'fileutils'
require 'yaml'

FileUtils.mkdir_p "data/artists"
FileUtils.mkdir_p "data/users"

MAX_TAGS = 10
MAX_ARTISTS = 20

users = %w[smeevil narnach fixato].map{|user| Scrobbler::User.new user}
artists = Array.new
tags = Array.new

users.each do |user|
  user_artists_file = "data/users/#{user.username}_artists.yml"
  if File.exist?(user_artists_file)
    artists << YAML.load_file(user_artists_file)[0...MAX_ARTISTS]
  else
    found_user_artists = user.top_artists
    File.open(user_artists_file,"w") {|f| f.write found_user_artists.to_yaml}
    artists << found_user_artists[0...MAX_ARTISTS]
  end
end

artists.flatten!
artist_frequencies = ActiveSupport::OrderedHash[artists.group_by {|artist| artist.name}.map{|artist, ary| [artist, ary.size]}.sort_by(&:last)]

artists.flatten.uniq.each do |artist|
  artist_tags_file = "data/artists/#{artist.name}_tags.yml"
  
  if File.exist?(artist_tags_file)
    found_artist_tags = YAML.load_file(artist_tags_file)[0...MAX_TAGS]
  else
    found_artist_tags = artist.top_tags
    File.open(artist_tags_file,"w") {|f| f.write found_artist_tags.to_yaml}
    artists << found_artist_tags
  end
  weighted_tags = found_artist_tags[0...MAX_TAGS] * artist_frequencies[artist.name] 
  tags << weighted_tags
end

tags.flatten!
tag_frequencies = tags.group_by {|tag| tag.name}.map{|tag, ary| [tag, ary.size]}.sort_by(&:last)


puts "==== Artists"
puts artist_frequencies.to_a[-10..-1].reverse.map{|artist, count| "%20s %5i %s" % [artist, count, "*"*count]}

puts "==== Tags"
puts tag_frequencies[-10..-1].reverse.map{|tag, count| "%20s %5i %s" % [tag, count, "*"*count]}