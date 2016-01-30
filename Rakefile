Bundler.require
Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

namespace :firebase do
  desc 'Update firebase'
  task :update do
    gen = Firebase::FirebaseTokenGenerator.new ENV['FIREBASE_SECRET']
    tkn = gen.create_token user:ENV['FIREBASE_USER']
    ref = Bigbertha::Ref.new ENV['FIREBASE_HOME'], tkn

    source_yaml = YAML.load_file ENV['SOURCE_YAML']||'./config/sources.yaml'
    client      = Engine::Client.new host:ENV['FOOD_TRUCKS_HOST'],
                                     port:ENV['FOOD_TRUCKS_PORT'],
                                     path:ENV['FOOD_TRUCKS_PATH']
    response    = source_yaml.map{|x| client.get x }.flatten
    ref.set response
  end
end
