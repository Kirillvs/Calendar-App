FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "example#{n}@example.com" }
    surname 'Surname'
    name 'Name'
    patronymic 'Patronymic'

    password 'changeme'
    password_confirmation { password }
  end
end
