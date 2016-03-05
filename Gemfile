ruby '2.3.0'
source 'https://rubygems.org'

# Food Trucks Engine
gem 'engine', git:'git://github.com/amancevice/food-trucks-engine', branch:'master'

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
