# frozen_string_literal: true

class Meet < ApplicationRecord
  belongs_to :room
  belongs_to :created_by, class_name: 'User', foreign_key: 'created_by_id'

  enum status: {
    scheduled: 'scheduled',
    canceled: 'canceled',
    finished: 'finished'
  }

  validate :period_conflict, if: :should_validate_period?

  validates :name,
            :status,
            :starts_at,
            :ends_at,
            presence: true

  validates :ends_at, date: { after: :starts_at }, if: :ends_at?

  validates :canceled_at, presence: true, if: :canceled?

  def cancel!
    self.canceled_at = DateTime.now
    canceled!
  end

  private

  def should_validate_period?
    scheduled? && period_present?
  end

  def period_present?
    starts_at.present? && ends_at.present?
  end

  def period_conflict
    conflicts = self.class.scheduled.where(
      'starts_at BETWEEN :starts_at AND :ends_at OR ends_at BETWEEN :starts_at AND :ends_at',
      { starts_at: starts_at, ends_at: ends_at }
    ).blank?

    return if conflicts

    errors.add(:base, "There's been a conflict on your times, please choose another set of times")
  end
end
