class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)

        if @comment.save
            redirect_to post_path(@comment.post)
        else
            flash[:notice] = "Comment must have content!"
            redirect_to post_path(@comment.post)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
