# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
    :user_name => 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
    :password => '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', # This is the secret sendgrid API key which was issued during API key creation
    :domain => 'jarvis.consulting',
    :address => 'smtp.sendgrid.net',
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true
  }