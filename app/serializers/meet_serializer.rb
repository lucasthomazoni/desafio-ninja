# frozen_string_literal: true

class MeetSerializer < ApplicationSerializer
  attributes :name,
             :errors,
             :status,
             :ends_at,
             :starts_at,
             :canceled_at,
             :created_by_id,
             :room_id
end
