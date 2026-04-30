# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    full { Faker::Address.full_address }
    lat { Faker::Address.latitude.to_s[0..31] }
    lng { Faker::Address.longitude.to_s[0..31] }

    association :weather
  end
end
