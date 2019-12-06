class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :user_conversations, dependent: :destroy
  has_many :conversations, through: :user_conversations
  has_many :notifications, dependent: :destroy
  has_one_attached :profile_pic
  validates :name, presence: true
  validates :email, uniqueness: true
  validates_numericality_of :age, greater_than: 13
  validates :bio, presence: true
  validates :bio, length: { minimum: 10 }
  has_secure_password

  def friend_ids
    first = Friendship.where("user_id == #{self.id} AND status == 'accepted'").pluck(:friend_id)
    second = Friendship.where("friend_id == #{self.id} AND status == 'accepted'").pluck(:user_id)
    user_ids = first + second
  end

  def friends
    User.where(id: self.friend_ids).order(:name)
  end

  def friend_count
    friends.count
  end

  def friendships
    Friendship.where("user_id == #{self.id} OR friend_id == #{self.id}")
  end

  def self.find_friends(sought_name)
    User.where("name LIKE ?", "%#{sought_name}%").order(:name)
  end

  def friend?(user)
    self.friends.find_by(id: user.id)
  end

  def friend_request_sent?(user)
    self.sent_friend_requests.find_by(id: user.id)
  end

  def friend_request_received?(user)
    self.received_friend_requests.find_by(id: user.id)
  end

  def find_friendship(user)
    a = Friendship.find_by(user: self, friend: user)
    b = Friendship.find_by(user: user, friend: self)

    a || b
  end

  def sent_friend_requests #returns list of people which have been sent a friend request by this user
    ids = Friendship.where("user_id == #{self.id} AND status == 'pending'").pluck(:friend_id)

    User.where(id: ids).order(:name)
  end

  def received_friend_requests #returns list of people which have sent a friend request to this user
    ids = Friendship.where("friend_id == #{self.id} AND status == 'pending'").pluck(:user_id)

    User.where(id: ids).order(:name)
  end

  def received_friend_requests_count
    received_friend_requests.count
  end

  def find_received_friend_request(friend)
    Friendship.find_by(user: friend, friend: self)
  end

  def most_hit
    posts.most_hit
  end

  def mutual_friends(user)
    User.where(id: self.friend_ids & user.friend_ids).order(:name)
  end

  def mutual_friend_count(user)
    mutual_friends(user).count
  end

  def unread_messages
    self.conversations.sum {|c| c.unread_messages(self)}
  end

  def notify_of_comment(comment)
    Notification.create(user: self, comment: comment)
  end

  def unread_notifications
    notifications.where(read: false)
  end

  def unread_notification_count
    unread_notifications.count
  end

end
