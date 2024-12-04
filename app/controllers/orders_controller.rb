class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
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
      product_id: params[:product_id], user_id: current_user.id, token: params[:token]
    )
  end 

  def set_item
    @product = Product.find(params[:product_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_8eeef4f239735229d44d9b92" # 自身のPAY.JPテスト秘密鍵
      Payjp::Charge.create(
        amount: @product.price,
        card: order_params[:token],
        currency: 'jpy'                # 通貨の種類（日本円）
      )
  end
end
