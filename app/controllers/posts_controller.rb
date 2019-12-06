class PostsController < ApplicationController
  
  before_action :authorize_user
  before_action :set_post
  before_action :set_user
  before_action :user_check, except: :show
  before_action :friend_check, only: :show

  def show
    @post.punch(request)
    @post.mark_comments_read(current_user)
    @comment = Comment.new
  end

  def create

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
    if params[:id]
      @post = Post.find(params[:id])
    else
      @post = Post.new(post_params)
    end
  end

  def set_user
    
    if params[:post]
        @user = User.find(params[:post][:user_id])
    else
        @user = @post.user
    end

  end


end
