class Owner::ProductsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_owner

  def create
    product = current_user.my_shop.products.build(product_params)
    if product.save
      redirect_to owner_shop_path, notice: "Product added."
    else
      redirect_to owner_shop_path, alert: product.errors.full_messages.to_sentence
    end
  end

  def destroy
    product = current_user.my_shop.products.find(params[:id])
    product.destroy
    redirect_to owner_shop_path, notice: "Product deleted."
  end

  private

  def product_params
    params.require(:product).permit(:name, :category)
  end

  
end
