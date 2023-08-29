class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :username ,:state, :age, :contact_no,:type ,:password
end
