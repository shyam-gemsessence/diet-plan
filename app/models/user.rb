class User < ApplicationRecord
  has_secure_password
  has_one :my_shop ,class_name: "Shop", foreign_key: :owner_id 
  has_many :products, through: :shop 
  has_many :selected_products , foreign_key: :customer_id, dependent: :destroy
  has_many :weekly_plans, foreign_key: :customer_id, dependent: :destroy 
  has_and_belongs_to_many :shops, join_table: "shops_users"
  validates :email, uniqueness: true
end
