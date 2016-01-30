load 'Rakefile'
require "rack-timeout"
use Rack::Timeout
Rack::Timeout.timeout = 500

while !Rake::Task['db:rollback'].invoke.nil?
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
end

class Service < Engine::Server
  get '/' do
    content_type :json
    handle_get params
  end

  post '/' do
    content_type :json
    handle_post params
  end
end

run Service
