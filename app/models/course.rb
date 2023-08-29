class Course < ApplicationRecord
 has_many :subscriptions, dependent: :destroy
 belongs_to :user
 belongs_to :category 
 validates :name, :status, :price, :duration, presence: true
 validates :status, inclusion: { in: %w(active inactive) }
 validates :name, uniqueness: { scope: :user_id, case_sensitive: false  }
#  validate :trainner_only_add_couse

# private
#  def trainner_only_add_couse
#   unless user.type == "Trainner"
#   errors.add(:base, "Only Trainner have permission to add Course.")      
#   end
#  end
 scope :active, -> { where(status: "active") }
 scope :inactive, -> { where(status: "inactive") }
end
