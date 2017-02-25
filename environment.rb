require 'active_record'
require 'pg'

# recursively requires all files in ./lib and down that end in .rb
Dir.glob('./lib/*').each do |folder|
  Dir.glob(folder + '/*.rb').each do |file|
    require file
  end
end

# tells AR what db file to use
if (ENV['DATABASE_ENV'] || 'development') == 'development'
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    username: 'user',
    database: 'edm-scraper',
  )
else
  ActiveRecord::Base.establish_connection(
    'postgres://hjfohnpcmkyinw:3fa8c5ca1d5d9640b840644ea05841f9088551bdf8a43a8e0f811cf09e68a3f0@ec2-23-21-96-70.compute-1.amazonaws.com:5432/dfak5idb6r86qh'
  )
end
