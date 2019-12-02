class FriendshipsController < ApplicationController

  def create
    Friendship.create(friends_params)
    redirect_to user_path(current_user)
  end

  private

  def friends_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
