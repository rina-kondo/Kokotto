class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path(user), notice: 'guestuserでログインしました'
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  # 退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password])
      if @user.is_deleted
        redirect_to new_user_registration_path, danger: "退会済みのアカウントです。ログインできません。"
      else
        sign_in(@user)
        redirect_to posts_path(current_user), notice: "ログインしました。"
      end
    end
  end

end
