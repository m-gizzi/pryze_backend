class Game < ApplicationRecord
  belongs_to :user
  has_many :donations
  has_many :fundraisers, through: :donations

  def generate_donations
    donations_array = []
    total_fundraisers = Fundraiser.all.length

    if self.amount * 100 > total_fundraisers
      max_donations = total_fundraisers
    else
      max_donations = self.amount * 100
    end

    number_of_donations = rand(1..max_donations).to_i
    recipient_fundraisers = (1..total_fundraisers).to_a.shuffle.take(number_of_donations)
    fundraiser_index = 0

    number_of_donations.times do
        donations_array.push({amount: nil, game_id: self.id, fundraiser_id: recipient_fundraisers[fundraiser_index]})
        fundraiser_index += 1
    end

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

    donations_array.each do |donation_hash|
      Donation.create(donation_hash)
    end

  end

end
