require 'postageapp'

def send_email_if_rescue(script_name, &block)
  begin
    block.call
  rescue Exception => exception
    PostageApp.configure do |config|
      config.api_key = ENV['POSTAGEAPP_API_KEY']
    end

    request = PostageApp::Request.new(
      :send_message,
      {
        headers: {
          from: ENV['DATABASE_ENV'] == 'production' ? 'edm-scraper@tbroadley.com' : 'edm-scraper-dev@tbroadley.com',
          subject: "EDM Scraper: error while running script '#{script_name}'",
        },
        recipients: 'buriedunderbooks@hotmail.com',
        content: {
          'text/plain': exception.backtrace.join('\n'),
        },
      }
    )

    request.send
  end
end
