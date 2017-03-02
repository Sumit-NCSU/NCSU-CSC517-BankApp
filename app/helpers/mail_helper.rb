require 'sendgrid-ruby'
include SendGrid
require 'json'

def send_sample_mail
  from = Email.new(email: 'csc517BankAppp@samplebank.com')
  subject = 'Hello Customer. Wassup.'
  to = Email.new(email: 'ssrivas8@ncsu.edu')
  content = Content.new(type: 'text/plain', value: 'This is working now!')
  mail = Mail.new(from, subject, to, content)
  # puts JSON.pretty_generate(mail.to_json)
  puts mail.to_json

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'], host: 'https://api.sendgrid.com')
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers
end