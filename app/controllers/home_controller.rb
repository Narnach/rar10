class HomeController < ApplicationController
  def index
    @tags=Tag.most_populair_genres(5)
    @total=@tags.sum{|t|t[1].to_i} 
    @colors=%w[red green blue yellow purple orange]
  end
end