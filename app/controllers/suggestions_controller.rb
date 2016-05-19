require "#{Rails.root}/lib/tunestakeoutwrapper.rb"

class SuggestionsController < ApplicationController
  def index
  # index: shows top 20 suggestions, ranked by total number of favorites
    @results = TunesTakeoutWrapper.top_twenty
    unless @results[0] == "<"
      @ids = @results["suggestions"]
      @restaurants = []
      @music = []
      @suggestions =[]
      @counter = 0
      @ids.each do |x|
        @list = TunesTakeoutWrapper.retrieve(x)["suggestion"]
        @restaurants << Food.search(@list["food_id"].parameterize)
        @music << Music.search(@list["music_type"], @list["music_id"])
        @suggestions << @list
      end
    end
  end

  def show
  end

  def search
  end

  def new_search
    @results = TunesTakeoutWrapper.find(params[:query])
    @suggestions = @results["suggestions"]
    # "id"=>"VzoWWvqqbQADSoRX",
    # "food_id"=>"ohana-seattle-2",
    # "music_id"=>"0BjkSCLEHlcsogSeDim01W",
    # "music_type"=>"track"}
    @restaurants = []
    @music = []
    @counter = -0
    @suggestions.each do |x|
      @restaurants << Food.search(x["food_id"].parameterize)
      @music << Music.search(x["music_type"], x["music_id"])
    end

    # for @music
      # album
        # name  =  .name
        # type   = .album_type
        # images = .images[1]["url"]
      # Artist

      #track

  end

  def add_favorite
    @favorite = TunesTakeoutWrapper.post_favorites(current_user.uid, params["format"])
    redirect_to root_path
    # render :new_search
  end

  def favorites
    @favorites = TunesTakeoutWrapper.get_favorites(current_user.uid)
    @ids = @favorites["suggestions"]
    @restaurants = []
    @music = []
    @suggestions =[]
    @counter = 0
    @ids.each do |x|
      @list = TunesTakeoutWrapper.retrieve(x)["suggestion"]
      @restaurants << Food.search(@list["food_id"].parameterize)
      @music << Music.search(@list["music_type"], @list["music_id"])
      @suggestions << @list
    end
  # favorites: shows all suggestions favorited by the signed-in User
  # favorite: adds a suggestion into the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  end

  def unfavorite
  # unfavorite: removes a suggestion from the favorite list for the signed-in User. This requires interaction with the Tunes & Takeout API.
  end
end
