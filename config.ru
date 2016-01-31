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
    params[:response] = handle_get params
    params.to_json
  end

  post '/' do
    content_type :json
    response = handle_post params
    { response:response }.to_json
  end
end

run Service
