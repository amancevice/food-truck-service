FROM ruby:2.3
MAINTAINER amancevice@cargometrics.com

ENV PLACE_CONFIG=/root/config/places.yaml \
    TRUCK_CONFIG=/root/config/trucks.yaml

WORKDIR /root

COPY Gemfile /root/
RUN bundle install --without heroku

COPY config/ /root/config/
COPY config.ru Rakefile /root/
COPY db/ db/

RUN bundle exec rake db:migrate db:seed

ENTRYPOINT [ "bundle", "exec", "rackup" ]
