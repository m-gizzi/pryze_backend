class User < ApplicationRecord
    has_many :creditCards
    has_many :games
    has_many :donations, through: :games
    has_many :fundraisers, through: :donations
    has_secure_password
    validates :username, uniqueness: { message: "%{value} has already been taken", case_sensitive: false }
    validates :email, uniqueness: { message: "An account already exists for %{value}", case_sensitive: false }

    #   Find the aggregate total for each fundraiser for the user
    def find_fundraisers_and_sort
        fundraiser_donations = []
        self.fundraisers.uniq.each do |fundraiser|
            donation_total = 0
            fundraiser.donations.each do |donation|
                if donation.fundraiser_id == fundraiser.id
                    donation_total += donation.amount
                end
            end
            fundraiser_donations.push({
                fundraiser_name: fundraiser.name,
                donation_amount: donation_total.round(2),
                url: fundraiser.url,
                id: fundraiser.id
            })
        end
        fundraiser_donations.sort do |a, b|
            b[:donation_amount] <=> a[:donation_amount]
        end
    end
end
