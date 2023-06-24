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
    current_user.now_latotide ? current_user.now_latotide : 0
    current_user.now_longitude ? current_user.now_longitude : 0

    lat_start = current_user.now_latitude - 1.0
    lat_end = current_user.now_latitude + 1.0
    long_start = current_user.now_longitude - 1.0
    long_end = current_user.now_longitude + 1.0

    @posts = Post.where(latitude: lat_start..lat_end, longitude: long_start..long_end).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc).page(params[:page]).per(5)
  end

  def destroy
    if Post.find(params[:id]).destroy
      redirect_to posts_path(current_user.id)
    else
      render :show, notice: "削除に失敗しました"
    end
  end

  def image_paths
    category = params[:category]
    image_paths = image_assets(category)
    respond_to do |format|
      format.json { render json: image_paths }
    end
  end

  private
  def user_location_params
    params.permit(:latitude, :longitude, :text, :image, :tag_name)
  end

end
