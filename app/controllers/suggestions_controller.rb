require "#{Rails.root}/lib/tunestakeoutwrapper.rb"

class SuggestionsController < ApplicationController

  skip_before_action :require_login, only: [:index, :loop_for_display, :user_check]

  def index
    user_check

    @results = TunesTakeoutWrapper.top_twenty

    unless @results[0] == "<"
      id = @results["suggestions"]
      loop_for_display(id)
    end
  end

  def new_search
    user_check

    @search = params[:query].downcase
    @results = TunesTakeoutWrapper.find(@search)
    @suggestions = @results["suggestions"]

    @restaurants = []
    @music = []
    @counter = 0
    @suggestions.each do |x|
      @restaurants << Food.search(x["food_id"].parameterize)
      @music << Music.search(x["music_type"], x["music_id"])
    end
  end


  def favorites
    @favorites = TunesTakeoutWrapper.get_favorites(current_user.uid)
    id = @favorites["suggestions"]

    loop_for_display(id)

    @fave_hash = @ids.map{ |x| [x, true] }.to_h
  end

  def add_favorite
    @favorite = TunesTakeoutWrapper.post_favorites(current_user.uid, params["format"])
    redirect_to root_path
  end

  def destroy
    TunesTakeoutWrapper.delete_favorites(current_user.uid, params["format"])
    redirect_to root_path
  end


  private
  def loop_for_display(id)
    @ids = id
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

  def user_check
    unless current_user.nil?
      @fave_hash = favorites
    end
  end
end
