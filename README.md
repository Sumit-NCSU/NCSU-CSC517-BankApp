# README

### Program 1: Bank Application

CSC517-Object Oriented Design and Development

Requirement Document: [Requirements](https://github.ncsu.edu/kebrey/CSC517-BankApp/wiki/Requirements)

How to user Guide: [How to Use](https://github.ncsu.edu/kebrey/CSC517-BankApp/wiki/How-to-Use-our-Application)

Assumptions made in the Application: [Assumptions](https://github.ncsu.edu/kebrey/CSC517-BankApp/wiki/Assumptions)

Default Admin Credentials:
Email: admin@ncsu.edu
Password: password

Default User Credentials:
Email: user@ncsu.edu
Password: password

Watch the below Video for instructions on how to use the application:

[Demo of Program 1: Bank Application](https://youtu.be/R8wiwcZe0dQ "Demo of Program 1: Bank Application")


* Ruby version 2.3.3
* Rails version 5.0.1
* Using sendgrid-ruby plugin for sending emails through our app

* Configuration Files:
  *   /config/database.yml
  *   Gemfile
  *   /config/environment/production.rb

* Database creation: 
  *   PostgreSQL on Heroku Production.
  *   Sqlite3 on local Development and Testing.

* Database initialization is done as follows (on production):
  *   > heroku run rake db:migrate --for migrating the database
  *   > heroku run rake db:seed --for seeding the database

* How to run the test suite:
  *   Test Files located at: /test
  *   To run test, on Windws:
      * open command prompt at the application's bin folder and type following command:
      *    > rails test

* Services (job queues, cache servers, search engines, etc.): NA

* Deployment instructions: Deployment on Heroku done using the following Guide:
  *   https://devcenter.heroku.com/articles/getting-started-with-rails5#local-workstation-setup
