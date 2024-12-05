class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :redirect_if_owner_or_sold, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"] #自身のPAY.JPテスト公開鍵
    @Products = Product.all
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
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
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @product.price,
      card: order_params[:token],
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end

  def redirect_if_owner_or_sold
    if current_user == @product.user || @product.order.present?
      redirect_to root_path
    end
  end
end
