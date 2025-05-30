# app/controllers/posts_controller.rb
class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]
    before_action :authorize_post_owner, only: [:update, :destroy]
  
    def index
      posts = Post.where('created_at >= ?', 24.hours.ago).includes(:comments)
      render json: posts.to_json(include: :comments)
    end
  
    def show
      render json: @post.to_json(include: :comments)
    end
  
    def create
      @post = @current_user.posts.build(post_params)
  
      if @post.save
        render json: @post, status: :created
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post.destroy
      head :no_content
    end
  
    private
  
    def set_post
      @post = Post.find(params[:id])
    end
  
    def authorize_post_owner
      return if @post.user_id == @current_user.id
  
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  
    def post_params
        params.require(:post).permit(:title, :body, tags: [])
    end
  end
  