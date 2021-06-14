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
  validate :period_availability, if: :should_validate_period?
  validate :period_maximum_time, if: :should_validate_period?

  validates :name,
            :status,
            :starts_at,
            :ends_at,
            presence: true

  validates :ends_at, date: { after: :starts_at }, if: :ends_at?

  validates :ends_at, date: { after:  proc { |o| o.ends_at.change(hour: 9, min: 0, sec: 0) } }, if: :ends_at?
  validates :ends_at, date: { before: proc { |o| o.ends_at.change(hour: 18, min: 0, sec: 1) } }, if: :ends_at?

  validates :starts_at, date: { after: proc { |o| o.starts_at.change(hour: 8, min: 59, sec: 59) } }, if: :starts_at?
  validates :starts_at, date: { before: proc { |o| o.starts_at.change(hour: 18, min: 0, sec: 0) } }, if: :starts_at?

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
    ).where.not(id: id).blank?

    return if conflicts

    errors.add(:base, "There's been a conflict on your times, please choose another set of times")
  end

  def period_availability
    errors.add(:starts_at, 'can only start on business days') if starts_at.on_weekend?
    errors.add(:ends_at, 'can only end on business days') if ends_at.on_weekend?
  end

  def period_maximum_time
    errors.add(:base, 'This meet is too long') if meet_bigger_than_9_hours?
  end

  def meet_bigger_than_9_hours?
    (ends_at - starts_at) > 9.hours
  end
end
