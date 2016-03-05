require 'bundler/setup'
Bundler.require
Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

namespace :firebase do
  desc 'Synchronize firebase with latest schedule'
  task :sync do
    # Get data from each source
    sources = YAML.load_file ENV['SOURCE_YAML']||'./config/sources.yaml'
    gigdata = sources.map do |src|
      puts src
      Engine::Helper.source(src.symbolize_keys).map do |res|
        Engine::Helper.gigs res
      end.flatten
    end.flatten

    # Format data for Firebase
    firedata = gigdata.map do |gig|
      { gig[:id] => gig.except(:id, :geoname, :type) }
    end.reduce &:merge

    # Push to Firebase
    Engine::Helper.firebase(
      secret:   ENV['FIREBASE_SECRET'],
      user:     ENV['FIREBASE_USER'],
      firebase: ENV['FIREBASE_HOME']).set firedata
  end
end
