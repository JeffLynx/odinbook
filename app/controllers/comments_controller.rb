class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back fallback_location: posts_path, notice: "Comment added!"
    else
      redirect_back fallback_location: posts_path, notice: "Could not add comment."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
    end

    redirect_to @post
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
