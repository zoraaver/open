class User < ApplicationRecord
    
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy
    validates :name, presence: true
    has_secure_password

    def friends
    
        first = Friendship.where("user_id == #{self.id} AND status == 'accepted'").pluck(:friend_id)
        second = Friendship.where("friend_id == #{self.id} AND status == 'accepted'").pluck(:user_id)
        user_ids = first + second
        User.where(id: user_ids).order(:name)
    end
    

end
