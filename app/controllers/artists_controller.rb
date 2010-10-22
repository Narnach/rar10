class ArtistsController < ApplicationController
  def index
    @artists=Artist.paginate(:page=>params[:page], :per_page=>12, :order=>:name)
  end
end