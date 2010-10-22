require 'scrobbler'
require 'fileutils'
require 'yaml'

FileUtils.mkdir_p "data/artists"
FileUtils.mkdir_p "data/users"

MAX_TAGS = 5
MAX_ARTISTS = 50

github_users = YAML.load_file("lib/tools/last_fm.yml").select{|username, attributes| attributes[:verified]}.map{|username, attributes| username}
github_users += %w[smeevil narnach fixato]
github_users.uniq!
users = github_users.map{|user| Scrobbler::User.new user}
artists = Array.new
tags = Array.new

users.each do |user|
  p user
  puts "Processing "#{user.username}""
  user_artists_file = "data/users/#{user.username.gsub(/\W/,"")}_artists.yml"
  old_file = "data/users/#{user.username}_artists.yml"
  if File.exist?(old_file)
    FileUtils.mv(old_file, user_artists_file) unless old_file == user_artists_file
  end
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

puts "==== Artists"
puts artist_frequencies.to_a[-10..-1].reverse.map{|artist, count| "%30s %5i %s" % [artist, count, "*"*count]}

artists.flatten.uniq.each do |artist|
  puts "Processing artist #{artist.name}"
  artist_tags_file = "data/artists/#{artist.name.gsub("&quot;","").gsub(/\W/,"-").squeeze("-").gsub(/^-|-$/,"")}_tags.yml"
  old_file = "data/artists/#{artist.name}_tags.yml"
  if File.exist?(old_file)
    FileUtils.mv(old_file, artist_tags_file) unless old_file == artist_tags_file
  end

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
puts artist_frequencies.to_a[-10..-1].reverse.map{|artist, count| "%30s %5i %s" % [artist, count, "*"*count]}

puts "==== Tags"
puts tag_frequencies[-10..-1].reverse.map{|tag, count| "%20s %5i %s" % [tag, count, "*"*count]}