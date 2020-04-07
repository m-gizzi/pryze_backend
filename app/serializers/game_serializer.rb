class GameSerializer < ActiveModel::Serializer
  attributes :id, :amount, :square_payment_id, :donations

  def donations
    @object.donations.map do |donation|
      {donation: donation, fundraiser: donation.fundraiser}
    end
  end
end
