class GamesController < ApplicationController

    def create
        payload = {
            "source_id": params[:nonce],
            "verification_token": params[:token],
            "autocomplete": true,
            "location_id": PryzeBackend::Application.credentials.square_location_id,
            "amount_money": {
              "amount": params[:amount],
              "currency": "USD"
            },
            "idempotency_key": SecureRandom.uuid
        }
        url = "https://connect.squareupsandbox.com/v2/payments"
        res = HTTP.auth("Bearer #{PryzeBackend::Application.credentials.sandbox_access_token}").post(url, :body => payload.to_json)
        result = res.parse
        
        if result["payment"]
            if params[:user]
                user = params[:user][:id]
            else
                user = User.first.id
            end
            game_attributes = {amount: (params[:amount].to_f / 100), user_id: user, square_payment_id: result["payment"]["id"]}
            game = Game.create(game_attributes)
            game.generate_donations
        end

        render json: result
    end
end
