class UserMailer < ApplicationMailer

  # using SendGrid's Ruby Library
  # https://github.com/sendgrid/sendgrid-ruby
  require 'sendgrid-ruby'
  include SendGrid

  def sendMail(email, message)
    puts "################################## SENDING EMAIL TO: #{email} The Mail body is: #{message} ##################################"
    from = Email.new(email: 'csc517bank@example.com')
    to = Email.new(email: email)
    subject = 'Transaction Alert from CSC517 BankApp'
    content = Content.new(type: 'text/plain', value: message)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end