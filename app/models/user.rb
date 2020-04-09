class User < ApplicationRecord
    has_many :creditCards
    has_many :games
    has_many :donations, through: :games
    has_secure_password
    validates :username, uniqueness: { message: "%{value} has already been taken", case_sensitive: false }
    validates :email, uniqueness: { message: "An account already exists for %{value}", case_sensitive: false }
end
