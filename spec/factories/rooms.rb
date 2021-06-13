# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { Faker::Company.unique.name }
  end
end
