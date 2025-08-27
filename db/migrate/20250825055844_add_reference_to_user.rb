class AddReferenceToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :shop, null: true, foreign_key: true
  end
end
