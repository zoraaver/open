class FriendshipsController < ApplicationController
  def create
    Friendship.create(friends_params)
  end

  def friends_params
    params.require(:friendship).permit(:user_id, :friend_id)
  end
end
