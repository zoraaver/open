class UsersController < ApplicationController
  before_action :authorize_user, except: [:new, :create]
  before_action :set_user, except: [:index, :new, :create, :friend_requests]
  before_action :user_check, only: [:update, :destroy, :edit]

  def index
    if params[:q]
      @users = User.find_friends(params[:q])
    end
  end

  def show
    @post = Post.new
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.friendships.destroy_all
    @user.destroy
    session.delete :user_id
    redirect_to "/login"
  end

  def friend_page

  end

  def friend_requests
    @requests = current_user.received_friend_requests

    render "friendships/requests"
  end

  def mutual
    @mutual_friends = current_user.mutual_friends(@user)
    @mutual_friend_count = current_user.mutual_friend_count(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio, :age, :profile_pic)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
