class CommentsController < ApplicationController

    before_action :set_comment, except: :create

    def create
        @comment = Comment.new(comment_params)

        if @comment.save
            redirect_to post_path(@comment.post)
        else
            flash[:notice] = "Comment must have content!"
            redirect_to post_path(@comment.post)
        end
    end

    def edit
        
    end

    def update
        if @comment.update(comment_params)
            redirect_to post_path(@comment.post)
        else
            flash[:notice] = "Comment must have content!"
            redirect_to post_path(@comment.post)
        end
    end


    def destroy
        redirect_to post_path(@comment.destroy.post)
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end
end
