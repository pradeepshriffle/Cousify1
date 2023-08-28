class User < ApplicationRecord
 has_many :courses, dependent: :destroy
 has_many :subscriptions, dependent: :destroy
 has_many :categories, dependent: :destroy
 has_secure_password
 validates :name, :email, :username, :contact_no, :state,:age,:type,:password_digest,  presence: true
 validates :email, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
 validates :username, uniqueness: true,format: { with: /\A\w+\z/ }                
 validates :password_digest, length: { minimum: 8 }, format: { with: /\A\S+\z/ }
 validates :name, length: { minimum: 2 }, format: { with: /\A[a-zA-Z]+ *[a-zA-Z]*\z/ }
 validates :contact_no, numericality: { only_integer: true },length: { is: 10 }
 validates :state, inclusion: { in: ['MP', 'Raj', 'UP', 'WB', 'UK', 'MH'],
 message: "%{value} is not from  list" }
 validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 10, less_than: 100 }
  
end
