class AuthenticationController < ApplicationController
skip_before_action :authorize_request, only: [:login, :signup]
  def signup
    user = User.new(user_params)
    if user.save
      user.image.attach(params[:user][:image]) if params[:user][:image].present?
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])
    if user&.authenticate(params[:user][:password])
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end
  


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end

end
