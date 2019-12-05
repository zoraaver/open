class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_conversations
  has_many :users, through: :user_conversations

  def non_participants(user)
    user.friends - self.users
  end

  def user_count
    users.count
  end
  
end
