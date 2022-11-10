class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.create(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    else
      render json: {error: subscription.errors.full_messages.to_sentence}, status: 400
    end
  end

  def update
    # binding.pry
    if Subscription.exists?(params[:subscription_id])
      current_sub = Subscription.find(params[:subscription_id])
      current_sub.update(subscription_params)
      render json: SubscriptionSerializer.new(current_sub), status: 200
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :frequency, :status, :tea_id, :customer_id)
  end

end