#
# Gulp image
#

FROM node:6.4

MAINTAINER Fabien D. <fabien@myprod.net>

RUN apt-get update && apt-get install -y --no-install-recommends \
    rubygems build-essential ruby-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Gulp & Bower
RUN npm install -gq gulp bower

# Install Gem Sass Compass
RUN gem install sass

RUN usermod -u ${DOCKER_USER_ID:-1000} www-data \
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}
