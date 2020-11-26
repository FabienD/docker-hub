#
# PHP 7.2.x FPM image
#

FROM php:7.2-fpm-buster

LABEL maintainer="fabien@myprod.net"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        libicu-dev \
        libxml2-dev \
        libxslt-dev \
        libssh2-1-dev \
        ssh \
        git \
        unzip \
        ca-certificates \
        gnupg \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install -a ssh2-1.1.2 \
    && pecl install -a apcu-5.1.18 \
    && pecl install -a mcrypt-1.0.3 \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) gd opcache mbstring \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql \
    && docker-php-ext-install zip bcmath intl exif soap xsl sockets \
    && docker-php-ext-enable ssh2 apcu mcrypt

# Composer installation (v1)
RUN curl -sS https://getcomposer.org/installer | php \
    -- --install-dir=${COMPOSER_HOME:-/usr/local/bin} \
    --filename=composer --1

# PHP Application configuration (php.ini override + FPM pool configuration)
ADD php-custom.ini /usr/local/etc/php/conf.d/
ADD www.conf /usr/local/etc/php-fpm.d/

RUN usermod -u ${DOCKER_USER_ID:-1000} www-data \
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}
