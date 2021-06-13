# frozen_string_literal: true

FactoryBot.define do
  factory :scheduled_meet, class: 'Meet' do
    name { "#{Faker::Company.unique.name} Meet" }
    scheduled_at { DateTime.now }
    starts_at { DateTime.now + 30.minutes }
    ends_at { DateTime.now + 60.minutes }
    status { :scheduled }
    canceled_at { nil }

    room { create(:room) }
    created_by { create(:user) }

    factory :canceled_meet do
      status { :canceled }
      canceled_at { DateTime.now + 10.minutes }
    end
  end
end
