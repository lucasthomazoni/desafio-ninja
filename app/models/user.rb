# frozen_string_literal: true

class User < ApplicationRecord
  has_many :meets, foreign_key: 'created_by_id'

  validates :name, presence: true
  validates :name, uniqueness: true
end
