class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy ? (redirect_to request.referer) : (render admin_user_path, notice: "削除に失敗しました")
  end
end
