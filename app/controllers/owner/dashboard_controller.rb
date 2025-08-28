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

    # Summary for each product per date
    summary = WeeklyPlan.includes(:product)
                        .where(shop_id: @shop.id)
                        .group(:delivery_date, :product_id)
                        .sum(:quantity)

    @summary_by_date = summary.group_by { |(date, _), _| date }

    # Detailed breakdown for toggled view (includes customer & product)
    @plans_by_date = WeeklyPlan.includes(:customer, :product)
                              .where(shop_id: @shop.id)
                              .group_by(&:delivery_date)
  end


  def shop
    @shop = current_user.my_shop
    @products = @shop.products
    @new_product = Product.new
  end

  private

  
end
       