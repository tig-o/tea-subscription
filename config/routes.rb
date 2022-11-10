Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/customers/:id/subscriptions", to: "subscriptions#create"
    end
  end
end
