class Product < ApplicationRecord
    enum category: { fruit: 0, vegetable: 1 }
    

    belongs_to :shop
    
    has_many :selected_products, dependent: :destroy
    has_many :weekly_plans, dependent: :destroy
    
    validates :name, presence: true, uniqueness: { scope: :shop_id, case_sensitive: false }
end
