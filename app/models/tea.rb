class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temp, :brew_time
  
  has_many :subscriptions
end