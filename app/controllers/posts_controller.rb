class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user

  def show
    @post.punch(request)

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

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      flash[:notice] = "Post must have content!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    redirect_to user_path(@post.destroy.user)
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
