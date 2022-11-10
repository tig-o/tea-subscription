require 'rails_helper'

RSpec.describe 'Cancel Subscription API' do
  before :each do
    @tigo = Customer.create(first_name: 'tigo', last_name: 'sil', email: 'tigosil@gmail.com', address: '999 Denver Street')
    @green = Tea.create(title: 'Green Tea', description: 'Great to jump start your day, caffinated', temp: '250F', brew_time: '3 Minutes')
    @tigo_sub = Subscription.create(title: "Green Tea", price: 2.99, frequency: 1, customer_id: @tigo.id, tea_id: @green.id)
    
    @subscription_params = {
      status: 'inactive'
    }
  end

  describe 'Happy Path' do
    it 'Cancels a subscription rendering it inactive' do
      patch "/api/v1/customers/#{@tigo.id}/subscriptions/#{@tigo_sub.id}", params: @subscription_params

      subscription = JSON.parse(response.body, symbolize_names: true)[:data]
      # binding.pry
      expect(response).to be_successful
      expect(subscription[:type]).to eq('subscription')

      expect(subscription[:attributes][:title]).to eq('Green Tea')
      expect(subscription[:attributes][:price]).to eq(2.99)
      expect(subscription[:attributes][:status]).to eq('inactive')
      expect(subscription[:attributes][:frequency]).to eq('weekly')

      expect(subscription[:attributes][:tea_id]).to eq(@green.id)
      expect(subscription[:attributes][:customer_id]).to eq(@tigo.id)
    end
  end

  describe 'Sad Path' do
    it 'Returns error if no status is provided' do
      patch "/api/v1/customers/#{@tigo.id}/subscriptions/#{@tigo_sub.id}"

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription).to have_key(:error)
      expect(subscription[:error]).to eq("Please provide status, no status found")
    end
  end
end
