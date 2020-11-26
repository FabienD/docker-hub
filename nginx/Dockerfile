#
# Nginx image
#

FROM nginx:1.14

LABEL maintainer="fabien@myprod.net"

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ADD nginx.tmpl /etc/nginx/
ADD symfony.tmpl /etc/nginx/


RUN wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz \
    && rm dockerize-linux-amd64-v0.6.1.tar.gz

RUN mkdir -p ${APP_BASE_DIR:-/var/www/} \
    && mkdir -p /etc/nginx/sites-enabled/ \
    mkdir -p ${APP_BASE_DIR:-/var/www/app/logs/nginx/} \
    && usermod -u ${DOCKER_USER_ID:-1000} www-data

CMD dockerize \
    -template /etc/nginx/nginx.tmpl:/etc/nginx/nginx.conf \
    -template /etc/nginx/symfony.tmpl:/etc/nginx/sites-enabled/symfony.conf \
    && nginx -g "daemon off;"
