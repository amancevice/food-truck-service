ruby '2.3.0'
source 'https://rubygems.org'

gem 'bigbertha', require: ['bigbertha', 'firebase_token_generator']
gem 'engine', git:'git://github.com/amancevice/food-trucks-engine', branch:'master'
gem "rack-timeout", require:'rack/timeout/base'
gem 'rake'
gem 'sinatra-activerecord', require:['sinatra/activerecord', 'sinatra/activerecord/rake']

group :development do
  gem 'pry'
end

group :development, :docker do
  gem 'sqlite3'
end

group :heroku do
  gem 'pg'
end
