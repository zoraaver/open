class PostsController < ApplicationController

    before_action :set_post, only: :show
    before_action :authorize_user

    def show
        @comment = Comment.new
    end


    def create

        @post = Post.create(post_params)

        if @post.save
            redirect_to user_path(current_user)
        else
            flash[:notice] = "Post must have content!"
            redirect_to user_path(current_user)
        end

    end

    private

    def post_params
        params.require(:post).permit(:content, :user_id)
    end

    def set_post
        @post = Post.find(params[:id])
    end

end
