class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    User.find_by(id: session[:user_id]) || User.new
  end

  def logged_in?
    current_user.id
  end

  def authorize_user
    unless logged_in?
      flash[:notice] = "You need to login to access this page."
      redirect_to "/login"
    end
  end

  def authenticate_user
    if !current_user
      redirect_to signin_path, notice: "You must be signed in to do that!"
    end
  end

  def user_check
    if logged_in?
      if @user != current_user
        flash[:notice] = "You are not authorized to perform this action."
        redirect_to user_path(current_user)
      end
    end
  end

  def friend_check
    if !current_user.friend?(@user) && current_user != @user
      flash[:notice] = "You are not friends with this person."
      redirect_to user_path(current_user)
    end
  end

end
