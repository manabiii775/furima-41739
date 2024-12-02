class OrdersController < ApplicationController
  def index
    @product = Item.find(params[:item_id])
    @orderform = OrderForm.new
  end
end
