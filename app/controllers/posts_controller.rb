class PostsController < ApplicationController
  def index
    @posts = Post
      .where(user: current_user.following + [ current_user ])
      .order(created_at: :desc)
      .includes(:user, :likes, :comments)
  end
end
