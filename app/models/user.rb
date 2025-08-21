class User < ApplicationRecord
  has_secure_password

  has_many :products, foreign_key: :owner_id , dependent: :destroy
  has_many :selected_products , foreign_key: :cutomer_id, dependent: :destroy
  has_many :weekly_plans, foreign_key: :customer_id, dependent: :destroy 
end
