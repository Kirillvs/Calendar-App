require 'rails_helper'

RSpec.describe User, type: :model do

  let(:attrs) { FactoryGirl.attributes_for(:user) }

  it 'check presence of email' do
    attrs[:email] = nil
    event = User.create(attrs)
    expect(event.errors[:email]).to include("can't be blank")
  end

  it 'check presence of surname' do
    attrs[:surname] = nil
    event = User.create(attrs)
    expect(event.errors[:surname]).to include("can't be blank")
  end

  it 'check presence of name' do
    attrs[:name] = nil
    event = User.create(attrs)
    expect(event.errors[:name]).to include("can't be blank")
  end

  context '#event_ids' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:my_event) { FactoryGirl.create(:event, user_id: user.id) }
    let!(:foreign_event) { FactoryGirl.create(:event) }

    it 'return only users events ids' do
      expect(user.event_ids).to include(my_event.id)
      expect(user.event_ids).not_to include(foreign_event.id)
    end
  end
end
