#
# redis Dockerfile
#
# Sets up a Docker container with redis
#
# Build the image by running:
#
#  docker build -t yiitest/redis-$REDIS_VERSION .
#
# Run the image, letting MariaDB listen on 3307 on the host:
#
#  docker run --name=redis-$REDIS_VERSION -d yiitest/redis-$REDIS_VERSION
#

# Pull base image.
# https://registry.hub.docker.com/_/debian/
FROM debian:wheezy

ENV REDIS_VERSION 2.8.12

# Install redis
# adopted from https://github.com/docker-library/redis/blob/master/2.6/Dockerfile
RUN \
  apt-get update  && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y gcc make libc6-dev curl
RUN \
  mkdir -p /usr/src/redis  && \
  curl -sSL "https://github.com/antirez/redis/archive/$REDIS_VERSION.tar.gz" -o redis.tar.gz  && \
  tar xzf redis.tar.gz -C /usr/src/redis --strip-components=1  && \
  rm redis.tar.gz
RUN \
  make -C /usr/src/redis  && \
  make -C /usr/src/redis install  && \
  rm -r /usr/src/redis

EXPOSE 6379
CMD [ "redis-server" ]
