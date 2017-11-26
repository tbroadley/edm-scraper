require 'active_record'
require 'pg'
require 'dotenv'

Dotenv.load

# recursively requires all files in ./lib and down that end in .rb
Dir.glob('./lib/**/*.rb').each do |file|
  require file
end

# tells AR what db file to use
if ENV['DATABASE_ENV'] == 'development'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: 'user',
    database: 'edm-scraper',
  )
else
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end
