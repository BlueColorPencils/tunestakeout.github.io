require 'httparty'

module TunesTakeoutWrapper
  BASE_URL = "https://tunes-takeout-api.herokuapp.com/v1"

  def self.find(query)
    data = HTTParty.get(BASE_URL+"/suggestions/search?query=#{query}").parsed_response
    # &limit=#{limit} for a limit
    # &seed=12345  for randomized add to end of url
    # returns
    #food_id":"avocados-mexican-restaurant-everett",
    #"music_id":"0r2HEDK9STwKSmzmeJiAle",
    #"music_type
  end

  def self.post_favorites(user, params)
    data = HTTParty.post(BASE_URL+"/users/#{user}/favorites", {:body => { :suggestion => params}.to_json})
  end

  def self.retrieve(suggestion)
    data = HTTParty.get(BASE_URL+"/suggestions/#{suggestion}").parsed_response
  end

  def self.top_twenty
      data = HTTParty.get(BASE_URL+"/suggestions/top?limit=20").parsed_response
  end

  def self.get_favorites(user)
    data = HTTParty.get(BASE_URL+"/users/#{user}/favorites").parsed_response
    #:user_id UID from Spotify's OAuth service.
    #returns
    # "suggestions" with "id"s in an array
    #user can also add favorites based on "suggestion": "suggestion-id"
  end

end
