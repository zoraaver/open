class FriendshipsController < ApplicationController

  def create
    Friendship.create(friends_params)
    redirect_to user_path(current_user)
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(friends_params)
    redirect_to user_path(current_user)
  end

  def destroy
    Friendship.find(params[:id]).destroy

    redirect_to user_path(current_user)
  end

  private

  def friends_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
