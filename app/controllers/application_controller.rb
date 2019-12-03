class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @user = (User.find_by(id: session[:user_id]) || User.new)
  end

  def logged_in?
    current_user.id
  end


  def authorize_user
    unless logged_in?
      flash[:notice] = "You need to login to access this page."
      redirect_to '/login'
    end
  end

end
