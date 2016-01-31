FROM ruby:2.3
MAINTAINER amancevice@cargometrics.com

ENV PLACE_CONFIG=/root/config/places.yaml \
    RACK_ENV=docker \
    SOURCE_CONFIG=/root/config/sources.yaml \
    TRUCK_CONFIG=/root/config/trucks.yaml

WORKDIR /root

COPY Gemfile /root/
RUN bundle install --without development heroku

COPY config/ /root/config/
COPY config.ru Rakefile /root/
COPY db/migrate db/migrate
COPY db/schema.rb db/seeds.rb db/

ENTRYPOINT [ "bundle", "exec", "rackup" ]
