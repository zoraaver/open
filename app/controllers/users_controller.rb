class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :authorize_user, except: :new

  def index
    if params[:q]
      @users = User.find_friends(params[:q])
    end
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def friend_page
    @user = User.find(params[:id])
  end

  def friend_requests
    @requests = current_user.received_friend_requests

    render "friendships/requests"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :age)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def filter_users
    User.select { |u| u.name == params[:q] }
  end
end
