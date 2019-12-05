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
    @user = User.find(params[:id])
    if logged_in?
      if @user != current_user
        flash[:notice] = "Please don't try to edit other people's account details!"
        redirect_to user_path(current_user)
      end
    end
  end

  helper_method :authenticate_user
end
