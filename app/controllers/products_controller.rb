class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_product, only: [:show, :edit, :update]
  before_action :move_index, only: [:edit, :update], unless: proc { current_user.id == @product.user_id }

  def index
    @products = Product.all.order(created_at: 'DESC')
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  

  private

  def product_params
    params.require(:product).permit(:name, :text, :category_id, :status_id, :delivery_charge_id, :area_id, :shipping_date_id,
                                    :price, :image).merge(user_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def move_index
    redirect_to action: :index
  end

end
