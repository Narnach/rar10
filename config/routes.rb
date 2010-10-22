ActionController::Routing::Routes.draw do |map|
  map.root :controller=>:home ,:action=>:index
  map.resources :lastfm_users, :only => [:index, :show]
  map.resources :artists,:only=>[:index]
end
