class UsersController < ApplicationController

  before_action :set_user

    def new
    end
  
    def create
      @user = User.create(user_params)
      return redirect_to controller: "users", action: "new" unless @user.save
      session[:user_id] = @user.id
      redirect_to controller: "welcome", action: "home"
    end

    def show

    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
  
end
