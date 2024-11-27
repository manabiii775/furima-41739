require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '商品出品できるとき' do
      it '正常に出品できる' do
        expect(@product).to be_valid
      end
    end
    context '商品出品できないとき' do
      it 'nameが空では出品できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Name can't be blank"
      end
      it 'descriptionが空では出品できない' do
        @product.description = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Description can't be blank"
      end
      it '画像が空では出品できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Image can't be blank"
      end
      it 'category_idが1では出品できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Category can't be blank"
      end
      it 'status_idが1では出品できない' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Status can't be blank"
      end
      it 'shipping_cost_idが1では出品できない' do
        @product.shipping_cost_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping cost can't be blank"
      end
      it 'prefecture_idが1では出品できない' do
        @product.prefecture_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'day_until_shipping_idが1では出品できない' do
        @product.day_until_shipping_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Day until shipping can't be blank"
      end
      it 'priceが空では出品できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceが全角数字では登録できない' do
        @product.price = '５００'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end
      it 'priceが300未満では出品できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end
      it 'priceが1000万以上では出品できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
      it 'priceが整数でないとき出品できない' do
        @product.price = 5000.5
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be an integer'
      end
      it 'userが紐づいていないと出品できない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include 'User must exist'
      end
    end
  end
end