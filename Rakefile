Bundler.require
Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

namespace :firebase do
  desc 'Synchronize firebase with latest schedule'
  task :sync do
    source = YAML.load_file ENV['SOURCE_YAML']||'./config/sources.yaml'
    response = source.map do |x|
      x.symbolize_keys!
      puts x
      klass = x[:class]&.constantize
      payload = klass&.new(x.reject{|k,v| k == :class }).response
      Engine.process!(payload)
    end.flatten

    firedata = response.map do |x|
      { x[:sha1] => x.reject{|k,v| k == :sha1 } }
    end.flatten.reduce(&:merge)

    gen = Firebase::FirebaseTokenGenerator.new ENV['FIREBASE_SECRET']
    tkn = gen.create_token user:ENV['FIREBASE_USER']
    ref = Bigbertha::Ref.new ENV['FIREBASE_HOME'], tkn
    ref.set firedata
  end
end
