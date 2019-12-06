class Notification < ApplicationRecord
    belongs_to :user
    belongs_to :comment
    delegate :post, to: :comment

    def notifier_name
        self.comment.user.name
    end

    def post_content
        self.post.content
    end

    def comment_content
        self.comment.content
    end
end
