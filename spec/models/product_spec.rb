require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '商品が出品出来る場合' do
      it 'nameとtext、category_idとstatus_id,delivery_charge_id,area_id,shipping_date_id,price,imageが存在すれば登録できること' do
        expect(@product).to be_valid
      end
    end

    context '商品が出品出来ない場合' do
      it 'nameが空では登録できない' do
        @product.name = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Name can't be blank"
      end

      it 'textが空では登録できない' do
        @product.text = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Text can't be blank"
      end

      it 'category_idが空では登録できない' do
        @product.category_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Category can't be blank"
      end

      it 'status_idが空では登録できない' do
        @product.status_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Status can't be blank"
      end

      it 'delivery_charge_idが空では登録できない' do
        @product.delivery_charge_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Delivery charge can't be blank"
      end

      it 'area_idが空では登録できない' do
        @product.area_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Area can't be blank"
      end

      it 'shipping_date_idが空では登録できない' do
        @product.shipping_date_id = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping date can't be blank"
      end

      it 'priceが空では登録できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end

      it 'priceが300以下では登録できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end

      it 'priceが9,999,999以上では登録できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end

      it 'priceが全角では登録できない' do
        @product.price = '５００'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end

      it 'imageがないと出品出来ない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include("Image can't be blank")
      end

      it 'priceが英数字混合では出品出来ない' do
        @product.price = '500a'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end

      it 'category_idが1では登録できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Category must be other than 1'
      end

      it 'status_idが1では登録できない' do
        @product.status_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Status must be other than 1'
      end

      it 'delivery_charge_idが1では登録できない' do
        @product.delivery_charge_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Delivery charge must be other than 1'
      end

      it 'area_idが1では登録できない' do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Area must be other than 1'
      end

      it 'shipping_date_idが1では登録できない' do
        @product.shipping_date_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include 'Shipping date must be other than 1'
      end
    end
  end
end
