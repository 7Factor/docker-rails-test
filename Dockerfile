FROM ruby:2.5.1

MAINTAINER Alex McConnell <alexmc3@gmail.com>

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    postgresql \
    postgresql-contrib \
    libpq-dev

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16.0

RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh -o install_nvm.sh \
  && bash install_nvm.sh

RUN . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN gem install rake -v 12.3.2 \
  && gem install rails -v 5.2.2 \
  && gem install nokogiri -v 1.10.1 \
  && gem install sassc -v 2.0.0 \
  && gem install pg -v 1.1.4

RUN service postgresql start \
  && su postgres -c "psql -c 'create role root with superuser login;'" \
  && su postgres -c "psql -c \"ALTER USER postgres PASSWORD 'postgres';\""
