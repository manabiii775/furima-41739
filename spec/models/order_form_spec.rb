require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, product_id: product.id)
    sleep(0.1)
  end

  describe '商品購入' do
    context '商品が購入できるとき' do
      it '正常に購入できる' do
        expect(@order_form).to be_valid
      end
      it 'building_nameが空でも購入できる' do
        @order_form.building_name = ''
        expect(@order_form).to be_valid
      end
    end
    context '商品が購入できないとき' do
      it 'postcodeが空だと購入できない' do
        @order_form.postcode = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Postcode can't be blank")
      end
      it 'postcodeが半角ハイフンを含む形でなければ購入できない' do
        @order_form.postcode = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Postcode is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが1では購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Prefecture can't be blank")
      end
      it 'municipalitiesが空では購入できない' do
        @order_form.municipalities = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Municipalities can't be blank")
      end
      it 'street_addressが空では購入できない' do
        @order_form.street_address = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Street address can't be blank")
      end
      it 'telephone_numberが空では購入できない' do
        @order_form.telephone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Telephone number can't be blank")
      end
      it 'telephone_numberが9桁以下では購入できない' do
        @order_form.telephone_number = '12345678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Telephone number is invalid. Only half-width numbers are allowed.")
      end
      it 'telephone_numberが12桁以上では購入できない' do
        @order_form.telephone_number = '1234567891234'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Telephone number is invalid. Only half-width numbers are allowed.")
      end
      it 'telephone_numberに半角数字以外が含まれている場合は購入できない' do
        @order_form.telephone_number = '123-4567-8901'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include ("Telephone number is invalid. Only half-width numbers are allowed.")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_form.user_id = ''
        @order_form.valid? 
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'productが紐付いていなければ購入できない' do
        @order_form.product_id = ''
        @order_form.valid? 
        expect(@order_form.errors.full_messages).to include("Product can't be blank")
      end
    end
  end
end