class Owner::DashboardController < ApplicationController

  layout "owner"
  before_action :authenticate_user
  before_action :ensure_owner

  
  def customers
    @shop = current_user.my_shop
    @customers = @shop.customers.where(role: 'customer')
  end

  def generate_plan
    result = WeeklyPlanGenerator.new(current_user).generate

    if result.success?
      redirect_to owner_report_path, notice: "Weekly plan generated successfully!"
    else
      redirect_to owner_dashboard_path, alert: result.error
    end
  end

  def report
    @shop = current_user.my_shop

    summary = WeeklyPlan.where(product_id: @shop.products.ids)
                        .group(:delivery_date, :product_id)
                        .sum(:quantity)

    # Explicitly group by delivery date for easy view rendering
    @summary_by_date = summary.group_by { |(date, _product_id), _| date }
  end


  def shop
    @shop = current_user.my_shop
    @products = @shop.products
    @new_product = Product.new
  end

  private

  
end
       