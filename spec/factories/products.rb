FactoryBot.define do
  factory :product do
    name                  { Faker::Name.initials(number: 5) }
    description           { Faker::Lorem.sentence }
    category_id           { 2 }
    status_id             { 2 }
    day_until_shipping_id { 2 }
    shipping_cost_id      { 2 }
    prefecture_id         { 2 }
    price                 { 1000 }

    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/image/test_image.png'), filename: 'test_image.png')
    end
  end
end
