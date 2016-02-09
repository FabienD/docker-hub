# Nginx Container
#
# Version 1.0

FROM nginx

MAINTAINER Fabien D. <fabien@myprod.net>

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz \
    && rm dockerize-linux-amd64-v0.2.0.tar.gz


RUN mkdir -p ${APP_BASE_DIR:-/var/www/} \
   && mkdir -p /etc/nginx/sites-enabled/

ADD nginx.tmpl /etc/nginx/
ADD symfony.tmpl /etc/nginx/

RUN usermod -u ${DOCKER_USER_ID:-1000} www-data

EXPOSE 80

CMD dockerize \
    -template /etc/nginx/nginx.tmpl:/etc/nginx/nginx.conf \
    -template /etc/nginx/symfony.tmpl:/etc/nginx/sites-enabled/symfony.conf \
    -stdout /var/log/nginx/access.log \
    -stderr /var/log/nginx/error.log \
    nginx