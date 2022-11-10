class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.create(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: 201
    end
  end

  private
  def subscription_params
    params.permit(:title, :price, :frequency, :status, :tea_id, :customer_id)
  end

end