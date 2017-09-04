require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:attrs) { FactoryGirl.attributes_for(:event, user_id: user.id) }

  it 'check presence of name' do
    attrs[:name] = nil
    event = Event.create(attrs)
    expect(event.errors[:name]).to include("can't be blank")
  end

  it 'check presence of description' do
    attrs[:description] = nil
    event = Event.create(attrs)
    expect(event.errors[:description]).to include("can't be blank")
  end
  it 'check presence of user_id' do
    attrs[:user_id] = nil
    event = Event.create(attrs)
    expect(event.errors[:user_id]).to include("can't be blank")
  end
  it 'check presence of start' do
    attrs[:start] = nil
    event = Event.create(attrs)
    expect(event.errors[:start]).to include("can't be blank")
  end

  it 'check presence of repeat_period if repetitive' do
    attrs[:repeat_period] = nil
    attrs[:repetitive] = true
    event = Event.create(attrs)
    expect(event.errors[:repeat_period]).to include("can't be blank")
  end

  context '.my' do
    let(:my_event) { FactoryGirl.create(:event, user_id: user.id) }
    let(:foreign_event) { FactoryGirl.create(:event) }
    it 'return my events' do
      expect(Event.my(user.id)).to include(my_event)
      expect(Event.my(user.id)).not_to include(foreign_event)
    end
  end

  context '.repetitable' do
    let(:common_event) { FactoryGirl.create(:event) }
    let(:repetitable_event) { FactoryGirl.create(:event, repetitive: true) }
    it 'return repetitable events' do
      expect(Event.repetitable).to include(repetitable_event)
      expect(Event.repetitable).not_to include(common_event)
    end
  end

  context '.all_year' do
    it 'returns repetitable events for next 365 days' do
      d = Time.now
      FactoryGirl.create(:event, start: d, repetitive: true, repeat_period: 'month')
      expected_dates = []
      expected_dates << d
      while d < Time.now.next_year do
        d = d.next_month
        expected_dates << d
      end
      all_year_events_dates = Event.all_year.map(&:start)

      expected_dates.map! { |i| i.to_date }
      all_year_events_dates.map! { |i| i.to_date }

      expect(all_year_events_dates).to eq(expected_dates)
    end
  end
end
