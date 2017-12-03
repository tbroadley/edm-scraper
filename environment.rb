# frozen_string_literal: true

require 'active_record'
require 'dotenv'
require 'nulldb/core'
require 'pg'

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
    database: 'edm-scraper'
  )
elsif ENV['DATABASE_ENV'] == 'test'
  NullDB.configure do |ndb|
    def ndb.project_root
      File.dirname(__FILE__)
    end
  end
  ActiveRecord::Base.establish_connection(adapter: :nulldb, schema: 'db/schema.rb')
else
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
end
