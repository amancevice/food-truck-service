require 'bundler/setup'
Bundler.require
Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

def gigdata
  sources = YAML.load_file ENV['SOURCE_YAML']||'./config/sources.yaml'
  gigdata = sources.map do |src|
    STDERR.puts src
    EaterAtlas::Helper.source(src.symbolize_keys).map do |res|
      EaterAtlas::Helper.update res
      EaterAtlas::Helper.gigs res
    end.flatten
  end.flatten
end

namespace :firebase do
  desc 'Synchronize firebase with latest schedule'
  task :sync do
    # Format data for Firebase
    firedata = EaterAtlas::Helper.firedata gigdata

    # Push to Firebase
    EaterAtlas::Helper.firebase(
      secret:   ENV['FIREBASE_SECRET'],
      user:     ENV['FIREBASE_USER'],
      firebase: ENV['FIREBASE_HOME']).set firedata
  end

  desc 'Show firebase sync data'
  task :test do
    # Format data for Firebase
    STDOUT.puts EaterAtlas::Helper.firedata(gigdata).to_json
  end
end
