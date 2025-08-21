class Product < ApplicationRecord
    enum category: { fruit: 0, vegetable: 1 }
    validates :name , uniqueness: true, presence: true

    belongs_to :owner , class_name: "User"
    
    has_many :selected_products, dependent: :destroy
    has_many :weekly_plans, dependent: :destroy
    
end
