class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    like = @post.likes.build(user: current_user)

    if like.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, alert: "You have already liked this."
    end
  end

  def destroy
    like = @post.likes.find_by!(user: current_user)
    like.destroy

    redirect_back fallback_location: root_path
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
