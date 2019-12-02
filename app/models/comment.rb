class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validates :content, presence: true

    def date
        created_at.strftime("%A %d %B %H:%M")
    end

end
