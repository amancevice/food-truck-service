ruby '2.5.1'
source 'https://rubygems.org'

# Food Trucks Engine
gem 'eater_atlas', git:'https://github.com/amancevice/eater-atlas-engine.git', tag:'0.2.0'

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
