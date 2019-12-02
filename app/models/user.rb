class User < ApplicationRecord
    
    has_many :comments, dependent: :destroy
    has_many :posts, dependent: :destroy

    has_secure_password

    def friends
    
        first = Friendship.where("user_id == #{self.id}").pluck(:friend_id)
        second = Friendship.where("friend_id == #{self.id}").pluck(:user_id)

        (first + second).map{|i| User.find(i)}
    end
    

    validates :name, presence: true
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy


end
