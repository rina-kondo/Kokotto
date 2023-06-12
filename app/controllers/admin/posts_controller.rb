class Admin::PostsController < ApplicationController
  def destroy
    @post = Post.find(params[:id])
    @post.destroy ? (redirect_to request.referer) : (render admin_user_path, notice: "削除に失敗しました")
  end
end
