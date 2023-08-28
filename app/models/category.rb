class Category < ApplicationRecord
  belongs_to :user
  has_many :courses, dependent: :destroy
  validates :name, presence:true, uniqueness: { case_sensitive: false }

end
