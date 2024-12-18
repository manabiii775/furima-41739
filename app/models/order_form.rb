class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postcode, :prefecture_id, :municipalities, :street_address, :telephone_number, :building_name, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :product_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :municipalities
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/,message: "is invalid. Only half-width numbers are allowed."}
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    order = Order.create(user_id:, product_id:)
    Address.create(postcode:, prefecture_id:, municipalities:, street_address:, building_name:, telephone_number:, order_id: order.id)
  end
end