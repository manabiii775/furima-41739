class ProductsController < ApplicationController
  def new
  end


  private

  def product_params
    params.require(:product).params(
      :name, :description, :category_id, :status_id,
      :day_until_shipping_id, :shipping_cost_id, :prefecture_id, :price, :image
    )merge(user_id: current_user.id)
  end
end
