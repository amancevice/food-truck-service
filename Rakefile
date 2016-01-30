Bundler.require
Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

namespace :firebase do
  desc 'Synchronize firebase with latest schedule'
  task :sync do
    gen = Firebase::FirebaseTokenGenerator.new ENV['FIREBASE_SECRET']
    tkn = gen.create_token user:ENV['FIREBASE_USER']
    ref = Bigbertha::Ref.new ENV['FIREBASE_HOME'], tkn

    source = YAML.load_file ENV['SOURCE_YAML']||'./config/sources.yaml'
    client = Engine::Client.new(
      host:ENV['FOOD_TRUCKS_HOST'],
      port:ENV['FOOD_TRUCKS_PORT'],
      path:ENV['FOOD_TRUCKS_PATH'])
    response = source.map{|x| client.get x }.flatten
    ref.set response.map{|x|
      day = Time.parse(x['start']).strftime '%A'
      Meal.between(start:x['start'], stop:x['stop']).map do |meal|
        { day => { meal => { Digest::SHA1.hexdigest(x.to_s) => x }}}
      end
    }.flatten.reduce(&:deep_merge)
  end
end
