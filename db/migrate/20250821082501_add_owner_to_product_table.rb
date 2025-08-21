class AddOwnerToProductTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :product_tables, :owner, null: false, foreign_key: {to_table: :users}
  end
end
