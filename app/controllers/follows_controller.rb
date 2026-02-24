class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_back fallback_location: root_path
  end

  def destroy
    follow = current_user.sent_follows.find(params[:id])
    follow.destroy
    redirect_back fallback_location: root_path
  end
end
