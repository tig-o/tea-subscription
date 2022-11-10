require 'rails_helper'

RSpec.describe 'Create Subscription API' do
  before :each do
    @tigo = Customer.create(first_name: 'tigo', last_name: 'sil', email: 'tigosil@gmail.com', address: '999 Denver Street')
    @green = Tea.create(title: 'Green Tea', description: 'Great to jump start your day, caffinated', temp: '250F', brew_time: '3 Minutes')
    
    @subscription_params = {
      title: 'Green Tea',
      price: 2.99,
      frequency: 'weekly',
      tea_id: @green.id,
      customer_id: @tigo.id
    }
  end

  describe 'Happy Path' do
    it 'Creates a new subscription per customer' do
      post "/api/v1/customers/#{@tigo.id}/subscriptions", params: @subscription_params

      subscription = JSON.parse(response.body, symbolize_names: true)[:data]
      # binding.pry
      expect(response).to be_successful
      expect(subscription[:type]).to eq('subscription')

      expect(subscription[:attributes][:title]).to eq('Green Tea')
      expect(subscription[:attributes][:price]).to eq(2.99)
      expect(subscription[:attributes][:status]).to eq('active')
      expect(subscription[:attributes][:frequency]).to eq('weekly')

      expect(subscription[:attributes][:tea_id]).to eq(@green.id)
      expect(subscription[:attributes][:customer_id]).to eq(@tigo.id)
    end
  end

  describe 'Sad Path' do
    it 'Returns an error when no tea and customer are provided' do
      missing_sub_params = {
        title: 'Green Tea',
        price: 2.99,
        frequency: 'weekly'
      }

      post "/api/v1/customers/#{@tigo.id}/subscriptions", params: missing_sub_params
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription[:error]).to eq('Customer must exist and Tea must exist')
    end
  end
end
