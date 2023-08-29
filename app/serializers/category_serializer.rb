class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name ,:createdby

  def createdby
    object.user.name
  end   
end
