class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, :surname, presence: true

  has_many :events

  def fio
    "#{surname} #{name} #{patronymic}"
  end

  def event_ids
    events.pluck(:id)
  end
end
