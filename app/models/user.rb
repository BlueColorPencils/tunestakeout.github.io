class User < ActiveRecord::Base
  validates :name, :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    if auth_hash["info"]["id"].nil?
      user = self.find_by(uid: auth_hash["info"]["uid"], provider: auth_hash["provider"])
    else
      user = self.find_by(uid: auth_hash["info"]["id"], provider: auth_hash["provider"])
    end
    # Find or create a user
    if !user.nil?
      return user #was found
    else
      user = User.new
      if auth_hash["info"]["id"].nil?
        user.uid = auth_hash["info"]["uid"]
      else
        user.uid = auth_hash["info"]["id"]
      end
      user.provider = auth_hash["provider"]
      user.name = auth_hash["info"]["display_name"]
      user.image_url = auth_hash["info"]["images"][0]["url"]
      user.save
    end
    user
  end
end
