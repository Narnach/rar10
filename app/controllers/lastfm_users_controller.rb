class LastfmUsersController < ApplicationController
  access_control do
    allow all, :to => [:index, :show]
  end

  def index
    @lastfm_users = LastfmUser.verified.paginate(:all, :page=>params[:page], :per_page=>10, :order=>"username")
  end

  def show
    @lastfm_user = LastfmUser.find(params[:id])
  end
end