class BuyShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :city, :street, :building, :phone_number, :user_id, :product_id, :buy_id, :token

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :area_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10}$|^\d{11}\z/ }
  end
  
  def save
    buy = Buy.create(product_id: product_id, user_id: user_id)

    Shipping.create(postal_code: postal_code, area_id: area_id, city: city, street: street, building: building, phone_number: phone_number, buy_id: buy.id)
  end
end