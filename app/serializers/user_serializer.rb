class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :full_name, :email, :square_id
end