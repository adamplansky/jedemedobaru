require 'rubygems'
require 'json'

class BlogController < ApplicationController
  def index
    @myClient = Tumblr::Client.new(
    :consumer_key => Rails.application.secrets.tumblr_key,
    :consumer_secret => Rails.application.secrets.tumblr_secret,
    :oauth_token => Rails.application.secrets.tumblr_oauth_token,
    :oauth_token_secret => Rails.application.secrets.tumblr_oauth_token_secret
    )

    @posts = @myClient.posts("jedemedobaru.tumblr.com", :limit => 20, :offset => 0)
#    puts @posts.inspect
    total_posts = @posts["total_posts"]
    total_page = total_posts / 20 # 20 = pocet posts na stranku (defaultni && maximalni)
    puts total_page
    for i in 0..total_page
      get_posts(i).each do |p|
        puts p["type"]
        puts p["id"]
        puts p["caption"]
        puts p["title"]
        puts p["body"]
     end
    end
  end
  
  private
  
  def get_posts(page)
    @posts = @myClient.posts("jedemedobaru.tumblr.com",  :offset => 20*page) # 20 = pocet posts na stranku (defaultni && maximalni)
    @posts["posts"]
  end
end