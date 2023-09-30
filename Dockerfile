FROM ruby:3.2.2-alpine
RUN apk update -q
RUN apk add build-base

ENV APP_PATH=/opt/vatlayer

RUN mkdir -p $APP_PATH
ADD vat_layer.gemspec $APP_PATH/
ADD Gemfile* $APP_PATH/

WORKDIR $APP_PATH
RUN bundle install
ADD . $APP_PATH

CMD ["rspec", "spec", "-fd"]

