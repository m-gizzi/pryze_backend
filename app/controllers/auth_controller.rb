class AuthController < ApplicationController

  def autologin
    decoded_token = decode_token(params[:auth][:token])
    user_id = decoded_token["user_id"]
    user = User.find_by(id: user_id)
    render json: user
  end

  def login
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token_payload = {user_id: user.id}
      token = encode_token(token_payload)
      render json: {user: UserSerializer.new(user), token: token}, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
