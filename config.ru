Bundler.require

Geocoder.configure api_key:ENV['GOOGLE_GEOCODER_API_KEY'], use_https:true

migration = ActiveRecord::Migration.new
[:places, :trucks, :patterns].each do |table|
  begin
    migration.drop_table table, if_exists:true
  rescue ActiveRecord::StatementInvalid
  end
end

Engine.migrate

ActiveRecord::Base.transaction do
  places_yaml = ENV['PLACE_CONFIG']||'./config/places.yaml'
  places = YAML.load_file(places_yaml).map do |city,city_config|
    city_config.map do |neighborhood,place_config|
      place_config.map do |name,attrs|
        attrs.symbolize_keys!
        attrs[:source] = 'Native'
        attrs.update name:name, city:city, neighborhood:neighborhood
        place = Place.create attrs.reject{|x| x == :patterns }
        attrs[:patterns]&.map{|x| place.patterns.create value:x }
        place
      end
    end.flatten
  end.flatten

  trucks_yaml = ENV['TRUCK_CONFIG']||'./config/trucks.yaml'
  trucks = YAML.load_file(trucks_yaml).map do |city,truck_config|
    truck_config.map do |name,attrs|
      attrs.symbolize_keys!
      attrs[:source] = 'Native'
      attrs.update name:name, city:city
      truck = Truck.create attrs.reject{|x| x == :patterns }
      attrs[:patterns]&.map{|x| truck.patterns.create value:x }
      truck
    end
  end.flatten
end

run Engine::Server
