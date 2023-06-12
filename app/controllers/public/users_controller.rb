class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def mypage
    @activities = current_user.activities　# 投稿とコメント一覧
  end

  def liked_posts
    @posts = current_user.liked_posts.order(created_at: :desc)
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
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(current_user.id)
    if current_user.name == "guest_user"
      redirect_to root_path
    end
  end

  def activities
    query = <<-SQL
      (SELECT 'Post' as record_type, id, created_at FROM posts WHERE user_id = :user_id)
      UNION ALL
      (SELECT 'Comment' as record_type, id, created_at FROM comments WHERE user_id = :user_id)
      ORDER BY created_at DESC
    SQL

    ActiveRecord::Base.connection.execute(
      ActiveRecord::Base.send(:sanitize_sql_array, [query, user_id: id])
    )
  end
end
