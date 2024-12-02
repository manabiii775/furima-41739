class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postcode, :prefecture_id, :municipalities, :street_address, :telephone_number, :building_name

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :municipalities
    validates :street_address
    validates :telephone_number, format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
  end
  def save(params,user_id)
    order = Order.create(item_id: params[:item_id].to_i, user_id: user_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, municipalities: municipalities, street_address: street_address, building_name: building_name, telephone_number: telephone_number, order_id: order.id)
  end
end