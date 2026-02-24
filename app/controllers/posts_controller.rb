class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post
      .where(user: current_user.following + [ current_user ])
      .order(created_at: :desc)
      .includes(:user, likes: [], comments: [:user])
  end

  def show
    @post = Post.includes(:user, comments: [:user]).find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Posted!"
    else
      @posts = Post
        .where(user: current_user.following + [ current_user ])
        .order(created_at: :desc)
        .includes(:user, likes: [], comments: [:user])

      render :index, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
