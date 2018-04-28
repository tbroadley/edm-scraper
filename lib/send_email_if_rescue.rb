# frozen_string_literal: true

require 'postageapp'

def sender_address
  if ENV['DATABASE_ENV'] == 'production'
    'edm-scraper@thomasbroadley.com'
  else
    'edm-scraper-dev@thomasbroadley.com'
  end
end

def exception_content(exception)
  "#{exception.message}\n\n#{exception.backtrace.join("\n")}"
end

def build_request(script_name, exception)
  PostageApp::Request.new(
    :send_message,
    headers: {
      from: sender_address,
      subject: "EDM Scraper: error while running script '#{script_name}'",
    },
    recipients: 'buriedunderbooks@hotmail.com',
    content: { 'text/html': "<code>#{exception_content(exception)}</code>" }
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
