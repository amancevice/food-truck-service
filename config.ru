Bundler.require

migration = ActiveRecord::Migration.new
migration.drop_table :places,   if_exists:true
migration.drop_table :trucks,   if_exists:true
migration.drop_table :patterns, if_exists:true

Engine.migrate

places = YAML.load_file(ENV['PLACE_CONFIG']).map do |city,city_config|
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

trucks = YAML.load_file(ENV['TRUCK_CONFIG']).map do |city,truck_config|
  truck_config.map do |name,attrs|
    attrs.symbolize_keys!
    attrs[:source] = 'Native'
    attrs.update name:name, city:city
    truck = Truck.create attrs.reject{|x| x == :patterns }
    attrs[:patterns]&.map{|x| truck.patterns.create value:x }
    truck
  end
end.flatten

run Engine::Server
