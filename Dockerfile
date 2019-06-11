FROM ruby:2.5.1

MAINTAINER Alex McConnell <alexmc3@gmail.com>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    sqlite3

RUN gem install rake -v 12.3.2 \
  && gem install rails -v 5.2.2 \
  && gem install nokogiri -v 1.10.1 \
  && gem install sassc -v 2.0.0

