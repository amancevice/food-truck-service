ActiveRecord::Base.transaction do
  places_yaml = YAML.load_file ENV['PLACE_CONFIG']||'./config/places.yaml'
  places = places_yaml.map do |city,city_config|
    city_config.map do |neighborhood,place_config|
      place_config.map do |place,attrs|
        puts "Place::#{city}::#{neighborhood}::#{place}"
        attrs.symbolize_keys!
        attrs[:source] = 'Native'
        attrs.update place:place, city:city, neighborhood:neighborhood
        place = Place.create attrs.except(:patterns)
        attrs[:patterns]&.map{|x| place.patterns.create value:x }
        place
      end
    end.flatten
  end.flatten

  trucks_yaml = YAML.load_file ENV['TRUCK_CONFIG']||'./config/trucks.yaml'
  trucks = trucks_yaml.sort.map do |city,truck_config|
    truck_config.map do |truck,attrs|
      puts "Truck::#{city}::#{truck}"
      attrs.symbolize_keys!
      attrs[:source] = 'Native'
      attrs.update truck:truck, city:city
      truck = Truck.create attrs.except(:patterns)
      attrs[:patterns]&.map{|x| truck.patterns.create value:x }
      truck
    end
  end.flatten
end
