class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_form).permit(
      :postcode, :prefecture_id, :municipalities, :street_address, :building_name, :telephone_number).merge(
      product_id: params[:product_id], user_id: current_user.id
    )
  end 

  def set_item
    @product = Product.find(params[:product_id])
  end
end
