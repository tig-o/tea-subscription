  <img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />  <img src="https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white" />  <img src="https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white"/> <img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white" /> <img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white" /> <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" /> 

# Tea Subscription Service API :tea:
Rails API for a Tea Subscription Service with the following endpoints:
- An endpoint to subscribe a customer to a tea subscription
- An endpoint to cancel a customer’s tea subscription
- An endpoint to see all of a customer’s subsciptions (active and cancelled)

Completion of this take home challenge requires the following:
- A strong understanding of Rails
- Ability to create restful routes
- Demonstration of well-organized code, following OOP
- Test Driven Development
- Clear documentation

## Technology
Built with:
  - Ruby 2.7.4
  - Rails 5.2.8.1
  - RSpec 3.11


## Setup
1. Ensure that you have the prerequisites or equivalent
2. Clone this repo and navigate to the root folder `cd tea-subscription`
3. Run `bundle install`
4. Run `rails db:{drop,create,migrate,seed}`
5. (Optional) To run the test suite, run `bundle exec rspec`
6. Run `rails s`

You should now be able to hit the API endpoints using Postman.
Default host is `http://localhost:3000`


## Database Schema
![Screen Shot 2022-11-10 at 12 30 01 AM](https://user-images.githubusercontent.com/6260483/201028326-fdee2e21-a1c1-454e-899a-1bdc472bc632.png)


# Endpoints
### Subscribe a customer to a tea subscription
#### POST /api/v1/customers/1/subscriptions
- Required Params
  - `title`, `price`, `frequency`, `tea_id`, and `customer_id`
  - Send required data in JSON format in the body of the request as displayed in the example below
- Example Request
  - `POST http://localhost:3000/api/v1/customers/1/subscriptions`
    <br></br>
  
  ```ruby
  body: {
    "title": "Green Tea",
    "price": 2.99,
    "frequency": "weekly",
    "tea_id": 1,
    "customer_id": 1
  }
  ```
- Example Response
  ```JSON
  {
      "data": {
          "id": 3,
          "type": "subscription",
          "attributes": {
              "title": "Green Tea",
              "price": 2.99,
              "status": "active",
              "frequency": "weekly",
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
 
  
<br>

### Cancel a customer’s tea subscription
#### PATCH /api/v1/customers/1/subscriptions/1
- Required Params
  - status: 'inactive'
- Example Request
  - `PATCH http://localhost:3000/api/v1/customers/1/subscriptions/1`
  - Does not remove record, just changes status to inactive.
- Example Response
  ```JSON
  {
      "data": {
          "id": 3,
          "type": "subscription",
          "attributes": {
              "title": "Green Tea",
              "price": 2.99,
              "status": "inactive",
              "frequency": "weekly",
              "customer_id": 1,
              "tea_id": 1
          }
      }
  }
  ```
  
<br>

### See all of a customer’s subscriptions (active and inactive)
#### GET /api/v1/customers/1/subscriptions
- Required Params
  - N/A
- Example Request
  - `GET http://localhost:3000/api/v1/customers/2/subscriptions`
- Example Response
  ```JSON
  {
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "Green Tea",
                "price": 2.99,
                "status": "inactive",
                "frequency": "weekly",
                "tea_id": 1,
                "customer_id": 1
            }
        }
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "Chai Tea",
                "price": 5.35,
                "status": "active",
                "frequency": "weekly",
                "tea_id": 2,
                "customer_id": 2
            }
        }
    ]
  }
