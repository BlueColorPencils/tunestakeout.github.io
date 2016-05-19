require 'yelp'

class Food < ActiveRecord::Base
  # Food: A plain Ruby object that receives and models data retrieved from the Yelp Search API. Wraps interactions with the Yelp Search API by leveraging the Yelp-Ruby gem.

  def self.search(place)
    Yelp.client.business("#{place}").business
  end
end
