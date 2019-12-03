class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :name, presence: true
  validates :email, uniqueness: true
  validates_numericality_of :age, greater_than: 13
  validates :bio, presence: true
  validates :bio, length: { minimum: 10 }
  has_secure_password

  def friends
    first = Friendship.where("user_id == #{self.id} AND status == 'accepted'").pluck(:friend_id)
    second = Friendship.where("friend_id == #{self.id} AND status == 'accepted'").pluck(:user_id)
    user_ids = first + second
    User.where(id: user_ids).order(:name)
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
end
