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
    
    puts "page: #{page}, page_size: #{PAGE_SIZE}"
    @allposts
    if @allposts.nil?
      @allposts = Array.new
    end
    @posts = @myClient.posts("jedemedobaru.tumblr.com", limit: PAGE_SIZE, offset: PAGE_SIZE * (page-1) )
    #puts @posts["posts"]
    @posts["posts"].each_index do |i|
      @allposts[(page-1)*5+i] = @posts["posts"][i]
    end
    i = 0
    while i < @allposts.count
      puts "i[#{i}]: #{@allposts[i]}"
      i+=1
    end
   
   
    total_posts         = @posts["total_posts"]
    
    puts "---------------------------------------------"
    puts page
    @allposts              = Kaminari.paginate_array(@allposts, total_count: total_posts).page(page).per(PAGE_SIZE)
 
    
  end #end index
  
end
