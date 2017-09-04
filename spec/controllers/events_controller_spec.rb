require 'rails_helper'
require_relative './shared_examples'

RSpec.describe EventsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:foreign_user) { FactoryGirl.create(:user) }

  let(:valid_attributes) { FactoryGirl.attributes_for(:event, user_id: user.id) }

  let(:invalid_attributes) { FactoryGirl.attributes_for(:event, name: nil, description: 'invalid') }


  context 'User signed in' do
    before(:example) { sign_in(user) }

    let!(:good_event) { FactoryGirl.create(:event, valid_attributes) }
    let!(:foreign_event) { FactoryGirl.create(:event, user_id: foreign_user.id) }

    describe "GET #index" do
      it "returns a success response" do
        get :index, params: {}
        expect(response).to be_success
      end
    end

    describe "GET #show" do
      it "returns a success response" do
        get :show, params: {id: good_event.id}
        expect(response).to be_success
      end
    end

    describe "GET #new" do
      it "returns a success response" do
        get :new, params: {}
        expect(response).to be_success
      end
    end

    describe "GET #edit" do
      context 'when user owner of event' do
        it "returns a success response" do
          get :edit, params: {id: good_event.id}
          expect(response).to be_success
        end
      end

      context 'when user not owner of event' do
        it_should_behave_like 'no access', :get, :edit, {}
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Event" do
          expect {
            post :create, params: {event: valid_attributes}
          }.to change(Event, :count).by(1)
        end

        it "redirects to the created event" do
          post :create, params: {event: valid_attributes}
          expect(response).to redirect_to(Event.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {event: invalid_attributes }
          expect(response).to be_success
        end

        it "creates a new Event" do
          expect {
            post :create, params: {event: invalid_attributes }
          }.not_to change(Event, :count)
        end
      end
    end

    describe "PUT #update" do
      context 'when user owner of event' do
        context "with valid params" do
          let(:new_attributes) {
            FactoryGirl.attributes_for(:event, name: 'another name', user_id: user.id)
          }

          it "updates the requested event" do
            put :update, params: {id: good_event.id, event: new_attributes}
            expect(Event.find(good_event.id).name).to eq(new_attributes[:name])
          end

          it "redirects to the event" do
            put :update, params: {id: good_event.id, event: valid_attributes}
            expect(response).to redirect_to(good_event)
          end
        end

        context "with invalid params" do
          it "returns a success response (i.e. to display the 'edit' template)" do
            put :update, params: {id: good_event.id, event: invalid_attributes}
            expect(response).to be_success
          end

          it "not updates the requested event" do
            put :update, params: {id: good_event.id, event: invalid_attributes}
            expect(Event.find(good_event.id).description).not_to eq(invalid_attributes[:description])
          end
        end
      end

      context 'when user not owner of event' do
        it_should_behave_like 'no access', :put, :update, { name: 'new name' }
      end
    end

    describe "DELETE #destroy" do
      context 'when user owner of event' do
        it "destroys the requested event" do
          expect {
            delete :destroy, params: {id: good_event.id}
          }.to change(Event, :count).by(-1)
        end

        it "redirects to the events list" do
          delete :destroy, params: {id: good_event.id}
          expect(response).to redirect_to(events_url)
        end
      end
    end

    context 'when user not owner of event' do
      it_should_behave_like 'no access', :delete, :destroy, {}
    end
  end

  context 'User not signed in' do
    describe "GET #index" do
      it_should_behave_like "not signed in user for", :get, :index, {}
    end

    describe "GET #show" do
      it_should_behave_like "not signed in user for", :get, :show, { id: 1 }
    end

    describe "GET #new" do
      it_should_behave_like "not signed in user for", :get, :new, {}
    end

    describe "GET #edit" do
      it_should_behave_like "not signed in user for", :get, :edit, { id: 1 }
    end

    describe "POST #create" do
      it_should_behave_like "not signed in user for", :post, :create, { event: { name: 'fake' } }
    end

    describe "PUT #update" do
      it_should_behave_like "not signed in user for", :put, :update, { id: 1, event: { name: 'fake' } }
    end

    describe "DELETE #destroy" do
      it_should_behave_like "not signed in user for", :delete, :destroy, { id: 1 }
    end
  end
end
