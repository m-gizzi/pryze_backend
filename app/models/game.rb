class Game < ApplicationRecord
  belongs_to :user
  has_many :donations
  has_many :fundraisers, through: :donations

  def self.create_square_payment(payment_info, user)
    payload = {
      "source_id": payment_info[:nonce],
      "customer_id": user[:square_id],
      "autocomplete": true,
      "location_id": PryzeBackend::Application.credentials.square_location_id,
      "amount_money": {
        "amount": payment_info[:amount],
        "currency": "USD"
      },
      "idempotency_key": SecureRandom.uuid
    }
    
    #   If the user is trying to pay with a saved card there is no nonce
    #   Source ID will be a CreditCard instance id
    if !payload[:source_id]
      credit_card = CreditCard.find_by(id: payment_info["ccof"])
      payload[:source_id] = credit_card.square_ccof_id
    end

    url = "https://connect.squareupsandbox.com/v2/payments"
    res = HTTP.auth("Bearer #{PryzeBackend::Application.credentials.sandbox_access_token}").post(url, :body => payload.to_json)
    res.parse
  end

  def self.save_card_and_pay(params, user)
    payload = {
      "card_nonce": params[:nonce],
      "billing_address": {
        "postal_code": params[:postal_code]
      }
    }
    url = "https://connect.squareupsandbox.com/v2/customers/#{user[:square_id]}/cards"
    res = HTTP.auth("Bearer #{PryzeBackend::Application.credentials.sandbox_access_token}").post(url, :body => payload.to_json)
    
    #   If errors are returned send them to the frontend to be displayed
    if res.parse["errors"]
      return res.parse
    end

    CreditCard.create(last_four: res.parse["card"]["last_4"], square_ccof_id: res.parse["card"]["id"], card_brand: res.parse["card"]["card_brand"], user_id: user["id"])

    #   Repackage info to be sent to method above
    payment_info = {
      nonce: res.parse["card"]["id"],
      token: params[:token],
      amount: params[:amount]
    }

    self.create_square_payment(payment_info, user)
  end

  def generate_donations
    donations_array = []
    total_fundraisers = Fundraiser.all.length

    #   Max number of subdonations is either number of cents
    #   donated, or the total number of fundraisers
    if self.amount * 100 > total_fundraisers
      max_donations = total_fundraisers
    else
      max_donations = self.amount * 100
    end

    number_of_donations = rand(1..max_donations).to_i

    #   Each fundraiser can't be chosen more than once
    recipient_fundraisers = (1..total_fundraisers).to_a.shuffle.take(number_of_donations)
    fundraiser_index = 0

    number_of_donations.times do
        donations_array.push({amount: nil, game_id: self.id, fundraiser_id: recipient_fundraisers[fundraiser_index]})
        fundraiser_index += 1
    end

    #   Generate each subdonation amount so that all add up to total
    amount_array = (2..(self.amount * 100 + number_of_donations - 1)).to_a.shuffle.take(number_of_donations - 1)
    amount_array.sort!

    donations_array.each_with_index do |donation_hash, index|

      if number_of_donations == 1
        amount = self.amount
      elsif index == 0
        amount = (amount_array[index] - 1).to_f / 100
      elsif index == donations_array.length - 1
        amount = (self.amount * 100 + number_of_donations - 1 - amount_array[index - 1]).to_f / 100
      else
        amount = (amount_array[index] - amount_array[index - 1] - 1).to_f / 100
      end

      donation_hash[:amount] = amount

    end

    #   Remove any donations that ended up as $0
    final_check = donations_array.filter do |donation_hash|
      donation_hash[:amount] != 0
    end
    
    final_check.each do |donation_hash|
      Donation.create(donation_hash)
    end

  end

end
