class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to  root_path(@prototype)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :status_id,
    :day_until_shipping_id, :shipping_cost_id, :prefecture_id, :price, :image).merge(user_id: current_user.id
  )
  end
end
