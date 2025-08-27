class ShopsController < ApplicationController
  
  before_action :authenticate_user
  layout "customer", except: [:create]

  def index
    @shops = Shop.includes(:products).all
  end
  
  def new
    @shop = Shop.new(owner_id: params[:owner_id])
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to owner_shop_path, notice: "Shop successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @shop = Shop.find(params[:id])
    @products = @shop.products
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :owner_id)
  end
end



