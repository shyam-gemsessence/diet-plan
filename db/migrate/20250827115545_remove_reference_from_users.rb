class RemoveReferenceFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :users, :shop, null: false, foreign_key: true
  end
end
