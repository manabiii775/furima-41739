FactoryBot.define do
  factory :order_form do
    product_id { 1 }
    user_id { 1 }
    postcode { Faker::Number.between(from: 100, to: 999).to_s + "-" + Faker::Number.between(from: 1000, to: 9999).to_s }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    municipalities { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.building_number }
    telephone_number { "0" + Faker::Number.between(from: 100000000, to: 9999999999).to_s }
  end
end