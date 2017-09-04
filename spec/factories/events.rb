FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    start Time.now
    repetitive false
    repeat_period :week
    user
  end
end
