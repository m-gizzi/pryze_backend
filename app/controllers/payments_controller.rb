class PaymentsController < ApplicationController

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
        render json: res.body.first
    end

end
