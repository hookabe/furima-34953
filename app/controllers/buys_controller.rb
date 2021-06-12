class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_product, only: [:create, :index]
  before_action :move_root_path, only: [:index, :create], if: proc { current_user.id == @product.user_id }
  before_action :move_root_path, only: [:index, :create], if: proc { @product.buy.present? }

  

  def index
    @buy_shipping = BuyShipping.new
  end

  def new
    @buy_shipping = BuyShipping.new
  end

  def create
    @buy_shipping = BuyShipping.new(buy_params)
    if @buy_shipping.valid?
      @buy_shipping.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buy_params
    params.require(:buy_shipping).permit(:postal_code, :area_id, :city, :street, :building, :phone_number, :buy_id).merge(user_id: current_user.id, product_id: params[:product_id], buy_id: params[:buy_id])
  end
    def set_product
    @product = Product.find(params[:product_id])
  end

  def move_root_path
    redirect_to root_path
  end

end
