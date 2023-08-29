class SubscriptionSerializer < ActiveModel::Serializer
  attributes :id, :customer_name,:course,:mobile, :status
  def course
    object.course.name
  end
end
