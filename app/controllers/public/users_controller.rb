class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]).per(5)
    @comments = current_user.comments.order(created_at: :desc).page(params[:page]).per(5)
  end

  def liked_posts
    @posts = current_user.liked_posts.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @user = current_user
  end

  def update
    if @user = User.update(user_params)
      redirect_to :mypage
    else
      render :edit
    end
  end

  def withdrawal
    @user = current_user
    if @user.update(is_deleted: true)
      redirect_to root_path
    else
      render :edit
    end
  end

 private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def ensure_guest_user
    @user = User.find(current_user.id)
    if current_user.name == "guest_user"
      redirect_to root_path
    end
  end

end
