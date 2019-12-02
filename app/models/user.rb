class User < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  validates :name, presence: true
  validates :email, uniqueness: true
  # validates :password, length: { in: 6..20 }
  # validates :password, presence: true
  validates_numericality_of :age, greater_than: 13
  validates :bio, presence: true
  validates :bio, length: { minimum: 2 }
  has_secure_password

  def friends
    first = Friendship.where("user_id == #{self.id} AND status == 'accepted'").pluck(:friend_id)
    second = Friendship.where("friend_id == #{self.id} AND status == 'accepted'").pluck(:user_id)
    user_ids = first + second
    User.where(id: user_ids).order(:name)
  end
end
