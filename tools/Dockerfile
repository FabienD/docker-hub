#
# Node, Gulp, Yarn tools images
#

FROM node:14

LABEL maintainer="fabien@myprod.net"

RUN apt-get update && apt-get install -y --no-install-recommends \
    rubygems build-essential ruby-dev ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    # Install Gulp & Bower
    && npm install -gq gulp \
    # Install Gem Sass
    && gem install -N sass \
    # Work dir
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

# Add USER and APP dir
RUN echo 'export PS1=" 💩 ${NODE_VERSION} | \[\033[1;37m\]\h \[\033[1;33m\]\W\[\033[0;38m\] \[\033[1;37m\]# \[\033[0m\]"' >> /home/node/.bashrc

WORKDIR ${APP_BASE_DIR:-/var/www/}
