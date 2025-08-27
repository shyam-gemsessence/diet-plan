class AddReferenceToSelectedProduct < ActiveRecord::Migration[7.1]
  def change
    add_reference :selected_products, :shop, null: true, foreign_key: true
  end
end
