class ArtistsController < ApplicationController
  def index
    @artists=Artist.paginate(:page=>params[:page], :per_page=>12, :order=>:name)
  end
  
  def show
    @artist=Artist.find(params[:id])
    @users=@artist.lastfm_users
  end
end