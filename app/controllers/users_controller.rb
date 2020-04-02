class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            token_payload = {user_id: user.id}
            token = encode_token(token_payload)
            
            payload = {
                "given_name": params[:user][:full_name],
                "email_address": params[:user][:email],
                "reference_id": "CP#{user.id}",
                "idempotency_key": SecureRandom.uuid
            }

            url = "https://connect.squareupsandbox.com/v2/customers"
            res = HTTP.auth("Bearer #{PryzeBackend::Application.credentials.sandbox_access_token}").post(url, :body => payload.to_json)
            
            hash = JSON.parse(res.body.first)
            user.assign_attributes(square_id: hash["customer"]["id"])
            user.save
            render json: {user: UserSerializer.new(user), token: token}, status: :created
        else
            render json: user.errors.messages, status: :not_acceptable
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :full_name, :email)
    end

end
