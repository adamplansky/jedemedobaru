require 'rubygems'
require 'json'

class BlogController < ApplicationController
  helper_method :mesice
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
      @allposts[(page-1)*PAGE_SIZE+i] = @posts["posts"][i]
    end
    
    total_posts = @posts["total_posts"]
    
    @allposts = Kaminari.paginate_array(@allposts, total_count: total_posts).page(page).per(PAGE_SIZE)
    puts @allposts
    
  end #end index
  
  private

   M_ARR = ["nil","leden", "únor", "březen", "duben", "květen", "červen", "červenec", "srpen", "září", "říjen", "listopad", "prosinec"];
  def mesice(m)
    M_ARR[m]
  end
  

  
end
