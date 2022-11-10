Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/customers/:id/subscriptions", to: "subscriptions#create"
      patch "/customers/:customer_id/subscriptions/:subscription_id", to: "subscriptions#update"
      get "/customers/:customer_id/subscriptions", to: "subscriptions#index"
    end
  end
end
