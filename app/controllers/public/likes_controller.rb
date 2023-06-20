class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    like = current_user.likes.new(post_id: params[:post_id])
    if like.save
      @post = Post.find(params[:post_id])
      @post.create_notification_like!(current_user)
      redirect_to request.referer
    else
      render request.referer
    end
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    if like.destroy
      @post = Post.find(params[:post_id])
      redirect_to request.referer
    else
      render request.referer
    end
  end
end
