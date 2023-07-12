class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  include Public::PostsHelper

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(user_location_params)
    if @post.save
      render json: { status: "success", message: "投稿しました" }, status: :created
    else
      render json: { status: "error", message: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    current_user.now_latitude = current_user.now_latitude || 0
    current_user.now_longitude = current_user.now_longitude || 0

    lat_start = current_user.now_latitude - 0.003
    lat_end = current_user.now_latitude + 0.003
    long_start = current_user.now_longitude - 0.003
    long_end = current_user.now_longitude + 0.003

    @posts = Post.joins(:user)
                 .where(users: { is_deleted: false })
                 .where("user_id = 1 OR (latitude BETWEEN ? AND ? AND longitude BETWEEN ? AND ?)",
                        lat_start, lat_end, long_start, long_end)
                 .order(created_at: :desc)
                 .page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.joins(:user)
                              .order(created_at: :desc)
                              .page(params[:page]).per(5)
  end

  def destroy
    if Post.find(params[:id]).destroy
      redirect_to posts_path(current_user.id)
    else
      render :show, notice: "削除に失敗しました"
    end
  end

  private
  def user_location_params
    params.permit(:latitude, :longitude, :text, :image, :tag_name, :prefecture_city)
  end

end
