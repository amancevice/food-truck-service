ActiveRecord::Base.transaction do
  places_yaml = YAML.load_file ENV['PLACE_CONFIG']||'./config/places.yaml'
  places = places_yaml.map do |city,city_config|
    city_config.map do |neighborhood,place_config|
      place_config.map do |name,attrs|
        puts "Place::#{city}::#{neighborhood}::#{name}"
        attrs.symbolize_keys!
        attrs[:source] = 'Native'
        attrs.update name:name, city:city, neighborhood:neighborhood
        place = Place.create attrs.reject{|x| x == :patterns }
        attrs[:patterns]&.map{|x| place.patterns.create value:x }
        place
      end
    end.flatten
  end.flatten

  trucks_yaml = YAML.load_file ENV['TRUCK_CONFIG']||'./config/trucks.yaml'
  trucks = trucks_yaml.sort.map do |city,truck_config|
    truck_config.map do |name,attrs|
      puts "Truck::#{city}::#{name}"
      attrs.symbolize_keys!
      attrs[:source] = 'Native'
      attrs.update name:name, city:city
      truck = Truck.create attrs.reject{|x| x == :patterns }
      attrs[:patterns]&.map{|x| truck.patterns.create value:x }
      truck
    end
  end.flatten
end
