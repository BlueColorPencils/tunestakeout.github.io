class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    # new: shows a view with OAuth sign-in link
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_or_create_from_omniauth(auth_hash)

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    # destroy: deletes user_id from session
    session.delete :user_id
    redirect_to root_path
  end

  def profile
    @check = current_user
  end

end
