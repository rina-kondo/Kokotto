class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(:created_at).reverse_order
    @comments = @user.comments.order(:created_at).reverse_order
  end

  def edit
  end

  def update

  end

  def deactivate
    @user = User.find(params[:id])
    if @user.update(is_deleted: true)
      redirect_to request.referer, notice: "成功しました"
    else
      redirect_to request.referer, alert: "失敗しました"
    end
  end

  def reactivate
    @user = User.find(params[:id])
    if @user.update(is_deleted: false)
      redirect_to request.referer, notice: "成功しました"
    else
      redirect_to request.referer, alert: "失敗しました"
    end
  end
end
