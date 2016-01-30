load 'Rakefile'

Rake::Task['db:reset'].invoke

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
