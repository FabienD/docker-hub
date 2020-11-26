#
# Transifex tx client image
#

FROM python:3.5

LABEL maintainer="fabien@myprod.net"

# Install Transifex clien
RUN easy_install pip \
    && pip install transifex-client

RUN mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}

ENTRYPOINT ["tx"]