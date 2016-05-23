require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @known = { "provider" => 'spotify',
      "info" => { "uid" => "bojackhorseman", "display_name" => "Bo Ho", "images" => ["url" => "www.google.com"] } }

    @unknown = { "provider" => 'spotify',
      "info" => { "uid" => "unknown_user", "display_name" => "unknown user", "images" => ["url" => "www.no.com"] } }

    @unknown_with_id = { "provider" => 'spotify',
      "info" => { "id" => "id_name", "display_name" => "id name", "images" => ["url" => "www.id.com"] } }
  end

  test "omniauth method creates a new user if user is not found" do
    @user = User.find_or_create_from_omniauth @unknown
    assert_equal "unknown user", @user.name
  end

  test "omniauth does not create a new user if user is found" do
    @user = User.find_or_create_from_omniauth @unknown
    @user1 = User.find_or_create_from_omniauth @unknown
    assert_equal @user, @user1
  end

  test "omniauth can create a user with the id and no uid" do
    @user = User.find_or_create_from_omniauth @unknown_with_id
    assert_equal "id_name", @user.uid
  end

end
