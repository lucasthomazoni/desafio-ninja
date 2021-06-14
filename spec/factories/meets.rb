# frozen_string_literal: true

FactoryBot.define do
  factory :scheduled_meet, class: 'Meet' do
    name { "#{Faker::Company.unique.name} Meet" }
    starts_at { DateTime.new(2021, 6, 14, 9, 0, 0) }
    ends_at { DateTime.new(2021, 6, 14, 10, 0, 0) }
    status { :scheduled }
    canceled_at { nil }

    room { create(:room) }
    created_by { create(:user) }

    factory :canceled_meet do
      status { :canceled }
      canceled_at { DateTime.new(2021, 06, 14, 9, 10, 0) }
    end
  end
end
