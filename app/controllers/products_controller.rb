class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    @products = Product.order(created_at: :desc)
  end

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

  def show
    @products = Product.find(params[:id])
  end

  def edit
    @products = Product.find(params[:id])
  end

  def update
    @products = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :category_id, :status_id,
    :day_until_shipping_id, :shipping_cost_id, :prefecture_id, :price, :image).merge(user_id: current_user.id
  )
  end

  def correct_user
    @product = Product.find(params[:id])
    return if current_user == @product.user
    redirect_to new_user_session_path
  end
end
