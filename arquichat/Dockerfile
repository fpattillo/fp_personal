#FROM ruby:2.7.1
FROM timbru31/ruby-node:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY Gemfile* ./

COPY Gemfile.lock /usr/src/app/Gemfile.lock

RUN gem install bundler -v 2.1.4

RUN bundle install

COPY . /usr/src/app
