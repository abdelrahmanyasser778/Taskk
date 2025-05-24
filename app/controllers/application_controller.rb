class ApplicationController < ActionController::API
  before_action :authorize_request
  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    decoded = decode_token(token)
    @current_user = User.find(decoded[:user_id])
  rescue
    render json: { errors: ['Unauthorized'] }, status: :unauthorized
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decode_token(token)
    decoded = JWT.decode(token, Rails.application.credentials.secret_key_base)[0]
    HashWithIndifferentAccess.new decoded
  end

end
