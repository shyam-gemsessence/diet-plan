class WeeklyPlanGenerator
  

  def initialize(owner)
    @shop = owner.my_shop
    @owner = owner
    @customers = @shop.customers
    @days = (Date.today.beginning_of_week..Date.today.end_of_week).to_a
  end

  def generate
    # Clean previous plans
    WeeklyPlan.where(customer_id: @customers.pluck(:id), shop_id: @shop.id).destroy_all
    
    
    
    product_customer_map = Hash.new { |h, k| h[k] = [] }
    @customers.each do |customer|
      customer.selected_products.where(shop_id: @shop.id).each do |sp|
        product_customer_map[sp.product_id] << customer.id
      end
    end

    product_day_map = {}
    product_ids = product_customer_map.keys.shuffle 

    product_ids.each_with_index do |pid, index|
      product_day_map[pid] = @days[index % 7] 
    end

    @customers.each do |customer|
      selected_product_ids = customer.selected_products.where(shop_id: @shop.id).pluck(:product_id)

      # Fill with random other products to make it 7 total
      other_product_ids = @shop.products.where.not(id: selected_product_ids).pluck(:id).shuffle
      needed = 7 - selected_product_ids.size
      weekly_product_ids = (selected_product_ids + other_product_ids.first(needed)).uniq

      # Ensure 7 unique products
      raise "Not enough unique products in the shop to generate weekly plan." if weekly_product_ids.size < 7

      used_days = []

      weekly_product_ids.each do |pid|
        # Try to assign globally shared day if this product is common (selected by multiple customers)
        day = product_day_map[pid]

        # If no shared day, assign a remaining day
        if day.nil? || used_days.include?(day)
          day = (@days - used_days).sample
        end

        quantity = SelectedProduct.find_by(customer_id: customer.id, product_id: pid, shop_id: @shop.id )&.quantity || 1

        used_days << day

        WeeklyPlan.create!(
          customer_id: customer.id,
          product_id: pid,
          shop_id: @shop.id,
          quantity: quantity,
          delivery_date: day,
          start_date: @days.first,
          end_date: @days.last
        )
      end
    end

    OpenStruct.new(success?: true)
  rescue => e
    OpenStruct.new(success?: false, error: e.message)
  end

end
