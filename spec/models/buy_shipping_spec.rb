require 'rails_helper'

RSpec.describe BuyShipping, type: :model do
  
  describe '商品購入' do

    before do
      user = FactoryBot.create(:user)
      product = FactoryBot.create(:product)
      @buy_shipping = FactoryBot.build(:buy_shipping, user_id: user.id, product_id: product.id)
      sleep(1)
    end

    context '商品が購入出来る場合' do
      it '全て正しく入力されていれば保存出来ること' do
        expect(@buy_shipping).to be_valid
      end
      it 'buildingは空でも保存出来ること' do
        @buy_shipping.building = ''
        expect(@buy_shipping).to be_valid
      end
    end

    context '商品が購入出来ない場合' do
      it 'postal_codeが空だと保存できないこと' do
        @buy_shipping.postal_code = ''
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @buy_shipping.postal_code = '1234567'
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'area_idが空では保存できないこと' do
        @buy_shipping.area_id = ''
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Area can't be blank")
      end
      it 'area_idが1では登録できない' do
        @buy_shipping.area_id = 1
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Area must be other than 1")
      end
      it 'cityが空では保存できないこと' do
        @buy_shipping.city = ''
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'streetが空では保存できないこと' do
        @buy_shipping.street = ''
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Street can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @buy_shipping.phone_number = ''
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberは11桁以内出ないと保存できないこと' do
        @buy_shipping.phone_number = '090123456789'
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは数値のみでないと保存できないこと' do
        @buy_shipping.phone_number = '090-1234-5678'
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは数値のみでないと保存できないこと(英数字混合)' do
        @buy_shipping.phone_number = '0901234567a'
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberは全角数字では保存できないこと' do
        @buy_shipping.phone_number = '０９０１２３４５６７８'
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Phone number is invalid")
      end
      it 'userが紐付いていないと保存できないこと' do
        @buy_shipping.user_id = nil
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'productが紐付いていないと保存できないこと' do
        @buy_shipping.product_id = nil
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Product can't be blank")
      end
      it 'tokenが空では保存できないこと' do
        @buy_shipping.token = nil
        @buy_shipping.valid?
        expect(@buy_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
