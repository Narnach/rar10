require 'open-uri'

@results=Hash.new
lang="Ruby"
i=1

while i<10
  puts "fetching page #{i} of language #{lang}"
  data=YAML.load(open("http://github.com/api/v2/yaml/repos/search/%25?language=#{lang}&start_page=#{i}").read)
  
  data["repositories"].each do |repo|
    puts repo.inspect
    @results[repo["username"]]={:followers=>repo["followers"], :score=>repo["score"], :forks=>[repo["forks"]]}
    puts "-------"
  end  
  
  i+=1;
end

puts @results.inspect

File.open("./data.yml","w") do |f|
  f.write YAML.dump(@results)
end

