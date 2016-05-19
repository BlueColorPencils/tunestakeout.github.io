require 'rspotify'

class Music < ActiveRecord::Base
  def self.search(type, id)
    if type.downcase == "artist"
      return RSpotify::Artist.find("#{id}")
    elsif type.downcase == "album"
      return RSpotify::Album.find("#{id}")
    elsif type.downcase == "track"
      return RSpotify::Track.find("#{id}").album
    elsif type.downcase == "playlist"
      return ""
    else
      return ""
    end
  end
end
