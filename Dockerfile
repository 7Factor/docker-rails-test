FROM ruby:2.5.1

MAINTAINER Alex McConnell <alexmc3@gmail.com>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    postgresql \
    postgresql-contrib \
    libpq-dev

RUN gem install rake -v 12.3.2 \
  && gem install rails -v 5.2.2 \
  && gem install nokogiri -v 1.10.1 \
  && gem install sassc -v 2.0.0 \
  && gem install pg -v 1.1.4

RUN service postgresql start \
  && su postgres -c "psql -c 'create role root with superuser login;'"
