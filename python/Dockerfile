#
# Python custom image
#

ARG PYTHON_VER=3.8

FROM python:${PYTHON_VER}-slim-buster

LABEL maintainer="fabien@myprod.net"

# OS utilities & dependancies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Python 3 libraries
RUN pip install virtualenv

# Add USER and APP dir
RUN usermod -u ${DOCKER_USER_ID:-1000} www-data \
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}
