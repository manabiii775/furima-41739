class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to  root_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
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
    redirect_to root_path
  end

  def set_item
    @product = Product.find(params[:id])
  end
end
