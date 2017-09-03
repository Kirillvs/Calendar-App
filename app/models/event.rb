class Event < ApplicationRecord
  belongs_to :user

  enum repeat_period: [ :day, :week, :month, :year ]

  validates :name, :description, :user_id, :start, :repetitive, presence: true
  validates :repeat_period, presence: true, if: :repetitive

end
