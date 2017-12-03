# frozen_string_literal: true

require 'postageapp'

def sender_address
  if ENV['DATABASE_ENV'] == 'production'
    'edm-scraper@tbroadley.com'
  else
    'edm-scraper-dev@tbroadley.com'
  end
end

def exception_content(exception)
  "#{exception.inspect}\n\n#{exception.backtrace.join('\n')}"
end

def build_request(script_name, exception)
  PostageApp::Request.new(
    :send_message,
    headers: {
      from: sender_address,
      subject: "EDM Scraper: error while running script '#{script_name}'",
    },
    recipients: 'buriedunderbooks@hotmail.com',
    content: { 'text/plain': exception_content(exception) }
  )
end

def send_email_if_rescue(script_name)
  yield
rescue StandardError => exception
  unless ENV['DATABASE_ENV'] == 'test'
    puts exception.inspect
    puts exception.backtrace
  end

  PostageApp.configure do |config|
    config.api_key = ENV['POSTAGEAPP_API_KEY']
  end

  build_request(script_name, exception).send
end
