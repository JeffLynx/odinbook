class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    followed_user = User.find(params[:followed_id])
    # Create a pending follow request
    Follow.create(follower: current_user, followed: followed_user, status: :pending)
    redirect_back fallback_location: users_path, notice: "Follow request sent!"
  end

  def destroy
    follow = Follow.find(params[:id])
    follow.destroy if follow.follower == current_user
    redirect_back fallback_location: users_path
  end

  def accept
    follow = Follow.find(params[:id])
    if follow.followed == current_user
      follow.update(status: :accepted)
      redirect_back fallback_location: follows_path, notice: "Follow request accepted!"
    else
      redirect_back fallback_location: follows_path, alert: "Not authorized."
    end
  end

  def reject
    follow = Follow.find(params[:id])
    if follow.followed == current_user
      follow.destroy
      redirect_back fallback_location: follows_path, notice: "Follow request rejected."
    else
      redirect_back fallback_location: follows_path, alert: "Not authorized."
    end
  end

  def index
    @received_follow_requests = current_user.received_follow_requests.includes(:follower)
  end
end
