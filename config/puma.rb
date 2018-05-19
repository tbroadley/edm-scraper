#!/usr/bin/env puma

require_relative '../environment.rb'
require_relative '../lib/email_builders.rb'
require_relative '../lib/models/show.rb'

def respond(body, content_type: 'text/plain', response_code: 200, **kwargs)
  [
    response_code,
    {
      'Content-Type' => content_type,
      'Content-Length' => body.length.to_s,
      **kwargs,
    },
    [body],
  ]
end

def generate_index(shows)
  %Q(
    <!DOCTYPE html>
    <html>
      <head>
        <title>EDM Scraper</title>
      </head>
      <body>
        #{email_body(shows)}
      </body>
    </html>
  )
end

app do |env|
  if env['REQUEST_METHOD'] == 'GET' && env['PATH_INFO'] == '/'
    shows = Show.interesting
    respond generate_index(shows), content_type: 'text/html'
  else
    respond 'Not found', response_code: 404
  end
end
