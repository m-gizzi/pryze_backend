class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email, :square_id, :credit_cards

  def credit_cards
    @object.creditCards.map do |credit_card|
      {id: credit_card.id, last_four: credit_card.last_four, card_brand: credit_card.card_brand}
    end
  end

end
