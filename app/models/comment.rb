class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    has_many :notifications, dependent: :destroy
    validates :content, presence: true

    def date
        updated_at.strftime("%A %d %B %H:%M")
    end

end
