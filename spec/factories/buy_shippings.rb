FactoryBot.define do
  factory :buy_shipping do
    postal_code { "123-4567" }
    area_id { Faker::Number.within(range: 2..48) }
    city { Faker::Address.city }
    street { Faker::Address.street_address }
    building { "ハイツ13" }
    phone_number { "09012345678" }
    association :user
    association :product
  end
end
