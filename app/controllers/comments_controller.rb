class CommentsController < ApplicationController


    before_action :authorize_user
    before_action :set_comment
    before_action :set_user
    before_action :user_check

    def create

        if @comment.save
            @user = @comment.post.user
            @user.notify_of_comment(@comment)
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
        if params[:id]
            @comment = Comment.find_by(id: params[:id])
        else 
            @comment = Comment.new(comment_params)
        end
    end

    def set_user
        if params[:comment]
            @user = User.find(params[:comment][:user_id])
        else
            @user = @comment.user
        end
    end

end
