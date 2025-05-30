# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:update, :destroy]
    before_action :authorize_comment_owner, only: [:update, :destroy]
  
    def create
      comment = @post.comments.build(comment_params.merge(user: @current_user))
      if comment.save
        render json: comment, status: :created
      else
        render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment.destroy
      head :no_content
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = @post.comments.find(params[:id])
    end
  
    def authorize_comment_owner
      return if @comment.user_id == @current_user.id
  
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  