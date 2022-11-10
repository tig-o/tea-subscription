require 'rails_helper'

RSpec.describe 'Subscriptions Index API' do
  before :each do
    @zac = Customer.create(first_name: 'zac', last_name: 'sil', email: 'zacsil@gmail.com', address: '999 Denver Street')
    @green = Tea.create(title: 'Green Tea', description: 'Great to jump start your day, caffinated', temp: '250F', brew_time: '3 Minutes')
    @sleepy_tea = Tea.create(title: 'Sleepy Tea', description: 'Great to wind down with some genji ball', temp: '3000F', brew_time: '10 Minutes')
    Subscription.create(title: "Green Tea", price: 2.99, frequency: 0, customer_id: @zac.id, tea_id: @green.id)
    Subscription.create(title: "Sleepy Tea", price: 9000, frequency: 3, customer_id: @zac.id, tea_id: @sleepy_tea.id)
  end

  describe 'Happy Path' do
    it 'Returns customer tea subs, both active and inactive' do
      get "/api/v1/customers/#{@zac.id}/subscriptions"

      subscription = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response).to be_successful
      expect(subscription[0][:attributes][:title]).to eq("Green Tea")
      expect(subscription[0][:attributes][:price]).to eq(2.99)
      expect(subscription[0][:attributes][:status]).to eq("active")
      expect(subscription[0][:attributes][:frequency]).to eq("once")
      expect(subscription[1][:attributes][:title]).to eq("Sleepy Tea")
      expect(subscription[1][:attributes][:price]).to eq(9000)
      expect(subscription[1][:attributes][:status]).to eq("active")
      expect(subscription[1][:attributes][:frequency]).to eq("monthly")
    end
  end

  describe 'Sad Path' do
    it 'Returns error if no customer found' do
      get "/api/v1/customers/9999/subscriptions"

      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(subscription[:error]).to eq('No user found')
    end
  end
end