class PostsController < ApplicationController

    before_action :set_post
    before_action :authorize_user

    def show
        
    end

    private

    def post_params
        params.require(:post).permit(:content, :user_id)
    end

    def set_post
        @post = Post.find(params[:id])
    end

end
