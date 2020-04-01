class UsersController < ApplicationController

    def create
        user = User.create(user_params)


        payload = {
            "given_name": params[:user][:full_name],
            "email_address": params[:user][:email],
            "reference_id": "CP#{user.id}",
            "idempotency_key": SecureRandom.uuid
          }

        url = "https://connect.squareupsandbox.com/v2/customers"
        res = HTTP.auth("Bearer EAAAEHBhag8_knyjMxvzMUemOm1_ae2SBg9vofCIm-vHn6DNHe5wPx74mzmHCY5H").post(url, :body => payload.to_json)
        hash = JSON.parse(res.body.first)
        user.assign_attributes(square_id: hash["customer"]["id"])
        user.save
        render json: user
    end
    
    private
    
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :full_name, :email)
    end

end
