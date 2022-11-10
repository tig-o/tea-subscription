# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Subscription.destroy_all
Customer.destroy_all
Tea.destroy_all

tigo = Customer.create(first_name: "tigo", last_name: "sil", email: "tigosil@gmail.com", address: "999 Denver Street")
nicole = Customer.create(first_name: "nicole", last_name: "sil", email: "nicolesil@gmail.com", address: "999 Denver Street")

green = Tea.create(title: "Green Tea", description: "Antioxidants and caffeine", temp: "250F", brew_time: "3 Minutes")
chai = Tea.create(title: "Chai Tea", description: "Blend of black tea, ginger, cloves, cardamom and cinnamon", temp: "350F", brew_time: "7 Minutes")

Subscription.create(title: "Green Tea", price: 2.75, frequency: 0, customer_id: tigo.id, tea_id: green.id)
Subscription.create(title: "Chai Tea", price: 5.35, frequency: 1, customer_id: nicole.id, tea_id: chai.id)