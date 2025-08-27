class CreateJoinTableShopsUsers < ActiveRecord::Migration[7.1]
  def change
    create_join_table :shops, :users do |t|
      # t.index [:shop_id, :user_id]
      # t.index [:user_id, :shop_id]
    end
  end
end
