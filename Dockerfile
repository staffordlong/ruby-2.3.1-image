FROM ubuntu:latest

MAINTAINER Andrew Scott <amscott@openmailbox.org>

RUN apt-get -y update
RUN apt-get -y install build-essential git openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev libmysqlclient-dev libpq-dev imagemagick phantomjs libffi-dev libmagickwand-dev libmagickcore-dev pkg-config

RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
  cd /tmp/ruby-build && \
  ./install.sh && \
  cd / && \
  rm -rf /tmp/ruby-build

#Build Ruby
RUN ruby-build -v 2.3.1 /usr/local

#Install bundler
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri

#Regen binstubs, whatever *that* means
RUN gem regenerate_binstubs