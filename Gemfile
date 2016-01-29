ruby '2.3.0'
source 'https://rubygems.org'

gem 'engine', git:'git://github.com/amancevice/food-trucks-engine', branch:'master'
gem 'rake'
gem 'sinatra-activerecord', require:['sinatra/activerecord/rake']

group :development do
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end
