class SelectedProduct < ApplicationRecord

  validates :quantity, numericality: { greater_than: 0 }
  belongs_to :customer ,class_name: "User"
  belongs_to :product
  belongs_to :shop
 
end
