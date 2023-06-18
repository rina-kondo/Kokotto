class Public::CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    if @comment.save
      @comment.create_notification_comment!(current_user)
      redirect_to post_path(@comment.post_id)
    else
      render :new
    end
  end

  def destroy
    if Comment.find(params[:id]).destroy
      @post = Post.find(params[:post_id])
      redirect_to post_path(@post)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
