require 'scrobbler'
data=YAML.load(File.read("last_fm.yml"))
data.each do |user,info|  
  puts "user : #{user}" if info[:verified]
end