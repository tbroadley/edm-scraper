require 'active_record'
require 'pg'

# recursively requires all files in ./lib and down that end in .rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder + '/*.rb').each do |file|
    require file
  end
end

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'user',
  database: 'edm-scraper',
)
