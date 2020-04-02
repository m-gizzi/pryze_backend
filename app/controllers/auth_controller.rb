class AuthController < ApplicationController

  def autologin
    decoded_token = decode_token(params[:auth][:token])
    user_id = decoded_token["user_id"]
    user = User.find_by(id: user_id)
    render json: user
  end

  def login
  end
end
