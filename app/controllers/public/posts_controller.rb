class Public::PostsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(user_location_params)
    if @post.save
      render json: { status: "success", message: "Post was successfully created." }, status: :created
    else
      render json: { status: "error", message: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    lat_start = params[:lat_start] || 30
    lat_end = params[:lat_end] || 40
    long_start = params[:long_start] || 130
    long_end = params[:long_end] || 140

    @posts = Post.where(latitude: lat_start..lat_end, longitude: long_start..long_end).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
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
    params.permit(:latitude, :longitude, :text, :image)
  end

end
