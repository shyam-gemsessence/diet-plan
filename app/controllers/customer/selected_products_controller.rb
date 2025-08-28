class Customer::SelectedProductsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_customer

  def create
    
    #check if customer has already selected product from this shop
    
    @shop = Shop.find( params[:shop_id] )
    if @shop.selected_products.where(customer_id: current_user.id ).exists?
      redirect_to shops_path, alert: "You already have a plan from this shop."
      return
    end
    
    
    product_ids = params[:product_ids]&.reject(&:blank?) || []
    quantities = params[:quantities] || []
    
    if product_ids.size != 3
      redirect_back fallback_location: shops_path, alert: "You must select exactly 3 products."
      return
    end 
    
  
    ActiveRecord::Base.transaction do
      # 1. Map shop to the customer
      current_user.shops << @shop unless current_user.shops.include?(@shop)

      # 2. Create selected products
      product_ids.each do |product_id|
        SelectedProduct.create!(
          customer_id: current_user.id,
          shop_id: @shop.id,
          product_id: product_id,
          quantity: quantities[product_id].to_i
        )
      end
    end

    shop = Shop.find( params[:shop_id] )
    result = WeeklyPlanGenerator.new(shop.owner).generate

    if result.success?
      redirect_to customer_view_plan_path, notice: "Weekly plan generated successfully!"
    else
      redirect_to shops_path, alert: result.error
    end
    #redirect_to shops_path, notice: "Selections saved. Wait for the shop owner to generate your plan."
  end

end
