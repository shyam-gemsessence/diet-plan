class CreateWeeklyPlans < ActiveRecord::Migration[7.1]
  def change
    create_table :weekly_plans do |t|
      t.references :customer, null: false, foreign_key: {to_table: :users}
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.date :delivery_date

      t.timestamps
    end
  end
end
