require 'rubygems'
require 'json'

class BlogController < ApplicationController
  
   PAGE_SIZE = 5
  
  def index
    @myClient           = Tumblr::Client.new(
    :consumer_key       => Rails.application.secrets.tumblr_key,
    :consumer_secret    => Rails.application.secrets.tumblr_secret,
    :oauth_token        => Rails.application.secrets.tumblr_oauth_token,
    :oauth_token_secret => Rails.application.secrets.tumblr_oauth_token_secret
    )
    
    page = params[:page].to_i
    if page == 0 
      page = 1
    end
    
    @allposts = Array.new
    
    @posts = @myClient.posts("jedemedobaru.tumblr.com", limit: PAGE_SIZE, offset: PAGE_SIZE * (page-1) )
    
    @posts["posts"].each_index do |i|
      @allposts[(page-1)*5+i] = @posts["posts"][i]
    end
    
    total_posts = @posts["total_posts"]
    
    @allposts = Kaminari.paginate_array(@allposts, total_count: total_posts).page(page).per(PAGE_SIZE)
 
    
  end #end index
  
end
