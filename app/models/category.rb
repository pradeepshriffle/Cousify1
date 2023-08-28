class Category < ApplicationRecord
 belongs_to :user
 has_many :courses, dependent: :destroy
 validates :name, presence:true, uniqueness: { case_sensitive: false }
 validates :name, inclusion: { in: ['Civilservice', 'Neet', 'IT', 'sharemarket', 'IIT'],
  message: " Please Traineer only add Civilservice', 'Neet', 'IT', 'sharemarket', 'IIT' categories " }
end
