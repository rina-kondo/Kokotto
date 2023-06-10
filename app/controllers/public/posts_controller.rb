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
    @posts = Post.all
  end

  def show
  end

  def destroy
  end

  private
  def user_location_params
    params.permit(:latitude, :longitude, :text, :image)
  end

end
