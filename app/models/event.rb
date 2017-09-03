class Event < ApplicationRecord
  belongs_to :user

  enum repeat_period: [ :day, :week, :month, :year ]

  validates :name, :description, :user_id, :start, presence: true
  validates :repeat_period, presence: true, if: :repetitive
  validates :repeat_period, inclusion: { in: Event.repeat_periods.keys }, if: :repetitive
end
