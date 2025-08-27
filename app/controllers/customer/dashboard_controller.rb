class Customer::DashboardController < ApplicationController

  layout "customer"
  before_action :authenticate_user

  def view_plan
    @customer = current_user
    @plans_by_shop = WeeklyPlan
      .includes(:product, :shop)
      .where(customer_id: @customer.id)
      .group_by(&:shop) 
  end

    
end   