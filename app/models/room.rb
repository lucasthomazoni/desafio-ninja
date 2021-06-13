# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :meets

  validates :name, presence: true
  validates :name, uniqueness: true
end
