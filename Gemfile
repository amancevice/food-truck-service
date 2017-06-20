ruby '2.4.1'
source 'https://rubygems.org'

# Food Trucks Engine
gem 'eater_atlas', git:'git://github.com/amancevice/eater-atlas-engine', tag:'0.1.6'

# Firebase
gem 'bigbertha', require: ['bigbertha', 'firebase_token_generator']

# Service Helpers
gem 'rake'
gem 'sinatra-activerecord', require:['sinatra/activerecord', 'sinatra/activerecord/rake']
gem 'sinatra-contrib', require:['sinatra/json']

group :development, :docker do
  gem 'sqlite3'
end

group :heroku do
  gem 'pg'
end
