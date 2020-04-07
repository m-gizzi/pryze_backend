class Fundraiser < ApplicationRecord
    has_many :donations
    has_many :games, through: :donations
end
