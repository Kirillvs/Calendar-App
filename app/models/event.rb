class Event < ApplicationRecord
  belongs_to :user

  attr_accessor :parent_id

  enum repeat_period: [ :day, :week, :month, :year ]

  validates :name, :description, :user_id, :start, presence: true
  validates :repeat_period, presence: true, if: :repetitive
  validates :repeat_period, inclusion: { in: Event.repeat_periods.keys }, if: :repetitive

  delegate :fio, to: :user, prefix: true, allow_nil: true
  delegate :id, to: :user, prefix: true, allow_nil: true

  scope :my, ->(my_id) { where(user_id: my_id) }
  scope :repetitable, -> { where(repetitive: true) }

  def self.all_year
    result = self.all.to_a
    self.repetitable.each do |event|
      current_event = event
      d = event.start
      while d < Time.now.next_year
        next_event = Event.new
        next_event.name = current_event.name
        next_event.description = current_event.description
        next_event.user_id = current_event.user_id
        next_event.repeat_period = current_event.repeat_period
        next_event.repetitive = current_event.repetitive
        next_event.parent_id = current_event.id || current_event.parent_id
        d = current_event.repeat_period == 'week' ? current_event.start.weeks_since(1) : current_event.instance_eval("start.next_#{current_event.repeat_period}")
        next_event.start = d
        result << next_event
        current_event = next_event
      end
    end
    result
  end
end
