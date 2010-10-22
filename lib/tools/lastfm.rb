require 'scrobbler'
require 'open-uri'
@results=YAML.load(File.read("data.yml"))
puts @results.count
@last_fm_results=Hash.new { |hash, key| hash[key] = Hash.new }
@results.keys.each do |name|
  puts "searching for #{name}..."
  last_fm_user=Scrobbler::User.new(name)
  top_artists=last_fm_user.top_artists
  if top_artists.any?
    begin 
      data=Hash.from_xml(open("http://ws.audioscrobbler.com/2.0/?method=user.getinfo&user=#{name}&api_key=de5e0d54ff219d0f8689ec358daa6d98").read)
      last_fm_name=data["lfm"]["user"]["realname"]
      puts "Hit for #{name} : #{last_fm_name}"
      github_user=YAML.load(open("http://github.com/api/v2/yaml/user/show/#{name}"))
      puts "github: #{github_user["user"]["name"]} lastfm: #{last_fm_name}"    
      verified=github_user["user"]["name"]==last_fm_name
      puts "verified : #{verified}"
      @last_fm_results[name]={:real_name=>last_fm_user.realname, :verified=>verified, :top_artists=>top_artists}
    rescue
      puts "could not find profile for #{name}..."
      @last_fm_results[name]={:real_name=>"Unknown", :verified=>false, :top_artists=>top_artists}  
    end    
  end
    
  File.open("./last_fm.yml","w") do |f|
    f.write YAML.dump(@last_fm_results)
  end
end

puts @last_fm_results.keys
