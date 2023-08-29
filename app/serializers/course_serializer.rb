class CourseSerializer < ActiveModel::Serializer
  attributes :id, :category,:coursecreatedby, :name,:duration, :status, :price

  def category
    object.category.name
  end
  def coursecreatedby
    object.user.name
  end 
end
