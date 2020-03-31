class PaymentsController < ApplicationController

    def create
        payload = {
            "source_id": params[:nonce],
            "verification_token": params[:token],
            "autocomplete": true,
            "location_id": "3J44BEJN11JNZ",
            "amount_money": {
              "amount": params[:amount],
              "currency": "USD"
            },
            "idempotency_key": SecureRandom.uuid
        }
        url = "https://connect.squareupsandbox.com/v2/payments"
        res = HTTP.auth("Bearer EAAAEHBhag8_knyjMxvzMUemOm1_ae2SBg9vofCIm-vHn6DNHe5wPx74mzmHCY5H").post(url, :body => payload.to_json)
        render json: res.body.first
    end

end
