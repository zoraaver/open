class UsersController < ApplicationController

  before_action :set_user, only: :show
  before_action :authorize_user, except: :new


  def show

  end
   
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    return redirect_to controller: "users", action: "new" unless @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def friend_page
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :age)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
