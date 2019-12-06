class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, through: :comments
  validates :content, presence: true
  acts_as_punchable

  def notifications_for(user)
    self.notifications.where(user: user)
  end

  def mark_comments_read(user)
    self.notifications_for(user).update(read: true)
  end

end
