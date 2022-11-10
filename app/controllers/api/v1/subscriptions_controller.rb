class Api::V1::SubscriptionsController < ApplicationController

  def index
    if Customer.exists?(params[:customer_id])
      customer = Customer.find(params[:customer_id])
      render json: SubscriptionSerializer.new(customer.subscriptions), status: 200
    else
      render json: { error: "No user found" }
    end 
  end

  def create
    subscription = Subscription.create(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: subscription.errors.full_messages.to_sentence}, status: 400
    end
  end

  def update
    if params[:status].nil?
      render json: { error: 'Please provide status, no status found'}
    # binding.pry
    else
      if Subscription.exists?(params[:subscription_id])
        current_sub = Subscription.find(params[:subscription_id])
        current_sub.update(subscription_params)
        render json: SubscriptionSerializer.new(current_sub), status: 200
      end
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :frequency, :status, :tea_id, :customer_id)
  end

end