class AddWeekToWeeklyPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :weekly_plans, :start_date, :date
    add_column :weekly_plans, :end_date, :date
  end
end
