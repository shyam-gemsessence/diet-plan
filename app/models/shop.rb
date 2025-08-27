class Shop < ApplicationRecord

  belongs_to :owner, class_name: "User"
  has_many :products, dependent: :destroy
  has_many :selected_products, dependent: :destroy
  has_many :WeeklyPlans, dependent: :destroy

   has_and_belongs_to_many :customers,
                          -> { where(role: 'customer') },
                          class_name: 'User',
                          join_table: 'shops_users'

end
