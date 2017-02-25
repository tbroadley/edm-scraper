require 'active_record'
require 'sqlite3'

# recursively requires all files in ./lib and down that end in .rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder + '/*.rb').each do |file|
    require file
  end
end

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'edm_scraper.db',
)
