
ARG PHP_VERSION
ARG APP_BASE_DIR=/var/www
ARG DOCKER_UID=1000
ARG DOCKER_GID=1000

#
# Secured Composer install
#

FROM php:${PHP_VERSION}-cli-bookworm AS composer

ADD php-cli.ini /usr/local/etc/php/conf.d/

COPY composer_install.sh .
RUN chmod u+x composer_install.sh \
    && ./composer_install.sh \
    && cp composer.phar /usr/local/bin/composer


#
# PHP_VERSION fpm (prod) image
#

FROM php:${PHP_VERSION}-fpm-bookworm as fpm

ARG APP_BASE_DIR
ARG DOCKER_UID
ARG DOCKER_GID


COPY --from=composer /usr/local/bin/composer /usr/local/bin/composer

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
        libonig-dev \
        libmagickwand-dev \
        libmemcached-dev \
        ssh \
        git \
        unzip \
        ca-certificates \
        gnupg \
        wget \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install -a apcu-5.1.24 \
    && pecl install -a imagick-3.7.0 \
    && pecl install -a grpc-1.66.0 \
    && pecl install -a protobuf-4.28.2 \
    && pecl install -a redis-6.0.2 \
    && pecl install -a memcached-3.2.0 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) gd opcache mbstring \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql \
    && docker-php-ext-install zip bcmath intl exif xsl sockets \
    && docker-php-ext-enable apcu imagick grpc protobuf redis memcached

ADD php-fpm.ini /usr/local/etc/php/conf.d/

RUN groupadd dockeruser --gid ${DOCKER_GID} \ 
    && useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} -m -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR} \
    && echo 'export PS1=" 🐘 ${PHP_VERSION} | \[\033[1;35m\]\h \[\033[1;34m\]\W\[\033[0;94m\] \[\033[1;35m\]# \[\033[0m\]"'  \
    >> /home/dockeruser/.bashrc

WORKDIR ${APP_BASE_DIR}


#
# PHP_VERSION cli image
#

FROM composer as cli

ARG APP_BASE_DIR
ARG DOCKER_UID
ARG DOCKER_GID

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
        libonig-dev \
        libmagickwand-dev \
        libmemcached-dev \
        ssh \
        git \
        unzip \
        ca-certificates \
        gnupg \
        wget \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install -a apcu-5.1.24 \
    && pecl install -a imagick-3.7.0 \
    && pecl install -a grpc-1.66.0 \
    && pecl install -a protobuf-4.28.2 \
    && pecl install -a redis-6.0.2 \
    && pecl install -a memcached-3.2.0 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) gd opcache mbstring \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql \
    && docker-php-ext-install zip bcmath intl exif xsl sockets \
    && docker-php-ext-enable apcu imagick grpc protobuf redis memcached

RUN groupadd dockeruser --gid ${DOCKER_GID} \ 
    && useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} -m -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR} \
    && echo 'export PS1=" 🐘 ${PHP_VERSION} | \[\033[1;35m\]\h \[\033[1;34m\]\W\[\033[0;94m\] \[\033[1;35m\]# \[\033[0m\]"'  \
    >> /home/dockeruser/.bashrc

WORKDIR ${APP_BASE_DIR}

#
# PHP_VERSION fpm (dev) image
#

FROM fpm as dev

RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket='tcp://blackfire:8707'" > $PHP_INI_DIR/conf.d/blackfire.ini

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/3.3.2.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-3.3.2 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-3.3.2 \
    && docker-php-ext-enable xdebug

ADD php-dev.ini /usr/local/etc/php/conf.d/
RUN rm /usr/local/etc/php/conf.d/php-fpm.ini