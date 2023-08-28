class Subscription < ApplicationRecord
 belongs_to :user
 belongs_to :course
 validates :course_id, presence: true, uniqueness: {scope: :user_id}
 validate :learner_only_purchase_courses
 

private
 def learner_only_purchase_courses
  unless user.type == "Learner"
  errors.add(:base, "Only Learner have permission to Purchase  Course.")      
  end
 end
 
 
end
