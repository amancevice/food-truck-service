FROM ruby:2.3
MAINTAINER amancevice@cargometrics.com

ENV PLACE_CONFIG=/root/config/places.yaml \
    TRUCK_CONFIG=/root/config/trucks.yaml

WORKDIR /root

COPY Gemfile config.ru config /root/

RUN bundle install

ENTRYPOINT [ "bundle", "exec", "rackup" ]
