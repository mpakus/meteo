# frozen_string_literal: true

FactoryBot.define do
  factory :weather do
    zip { Faker::Address.zip }
  end
end
