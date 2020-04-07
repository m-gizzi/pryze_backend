class Donation < ApplicationRecord
  belongs_to :game
  belongs_to :fundraiser
end
