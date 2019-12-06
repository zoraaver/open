class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :user_conversations, dependent: :destroy 
  has_many :users, through: :user_conversations

  def non_participants(user)
    user.friends - self.users
  end

  def user_count
    users.count
  end

  def message_count
    messages.count
  end

  def find_uc(user) #uc ~ user_conversation for given user
    self.user_conversations.find_by(user: user)
  end

  def mark_messages_as_read(user)
    self.find_uc(user).update(read_messages: self.message_count)
  end

  def unread_messages(user) #gives no. of unread messages for a given user
    self.message_count - self.find_uc(user).read_messages
  end
  
end
