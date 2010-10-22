# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

users = YAML.load_file 'lib/tools/last_fm.yml'
users.each do |username, attributes|
  puts "=== User: #{username}"
  user = LastfmUser.find_or_initialize_by_username(username)
  if user.new_record?
    attributes.each do |k,v|
      user.send("#{k}=", v)
    end
    user.save!
  end
  next unless user.verified?
  artists = YAML.load_file("data/users/#{username.gsub(/\W/,"")}_artists.yml")
  artists[0...20].each do |artist_data|
    artist = Artist.find_or_initialize_by_name(artist_data.name)
    puts artist.name
    if artist.new_record?
      artist.image_url = artist_data.image
      artist.lastfm_url = artist_data.url
      artist.image_url = artist_data.image
      artist.save!
    end
    user.artists << artist
    unless artist.tags.any?
      tags = YAML.load_file("data/artists/#{artist.name.gsub("&quot;","").gsub(/\W/,"-").squeeze("-").gsub(/^-|-$/,"")}_tags.yml")
      tags[0...5].each do |tag_data|
        tag = Tag.find_or_create_by_name(tag_data.name)
        artist.tags << tag
      end
    end
  end
end
