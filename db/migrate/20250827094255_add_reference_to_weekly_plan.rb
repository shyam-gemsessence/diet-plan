class AddReferenceToWeeklyPlan < ActiveRecord::Migration[7.1]
  def change
    add_reference :weekly_plans, :shop, null: false, foreign_key: true
  end
end
