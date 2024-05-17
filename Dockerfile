ARG RUBY_VERSION=3.3.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

ENV BUNDLER_VERSION=2.5.10

RUN apt update && apt install -y --no-install-recommends \
build-essential \
ruby-dev \
git \
curl \
&& rm -rf /var/lib/apt/lists/*

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle check || bundle install

COPY . ./
ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]


