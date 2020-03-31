#
# Node, Gulp, Yarn tools images
#

FROM node:13

MAINTAINER Fabien D. <fabien@myprod.net>

RUN apt-get update && apt-get install -y --no-install-recommends \
    rubygems build-essential ruby-dev ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    # Install Gulp & Bower
    && npm install -gq gulp \
    # Install Gem Sass
    && gem install -N sass \
    # Work dir
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}
