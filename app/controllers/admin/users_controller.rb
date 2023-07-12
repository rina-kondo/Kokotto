class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(:created_at).reverse_order.page(params[:page]).per(5)
    @comments = @user.comments.order(:created_at).reverse_order.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user = User.update(user_params)
      redirect_to request.referer, notice: "会員情報を編集しました"
    else
      render :edit
    end
  end

  def deactivate
    @user = User.find(params[:id])
    if @user.update(is_deleted: true)
      redirect_to request.referer, notice: "アカウントを無効にしました"
    else
      redirect_to request.referer, alert: "アカウントの無効化に失敗しました"
    end
  end

  def reactivate
    @user = User.find(params[:id])
    if @user.update(is_deleted: false)
      redirect_to request.referer, notice: "アカウントを有効にしました"
    else
      redirect_to request.referer, alert: "アカウントの有効化に失敗しました"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end

