
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
COPY php_additional_install.sh .

RUN chmod u+x php_additional_install.sh && ./php_additional_install.sh

ADD php-fpm.ini /usr/local/etc/php/conf.d/

RUN useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} -m -s /bin/bash \
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

COPY php_additional_install.sh .
RUN php_additional_install.sh

RUN useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} -m -s /bin/bash \
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
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/3.3.0.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-3.3.0 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-3.3.0 \
    && docker-php-ext-enable xdebug

ADD php-dev.ini /usr/local/etc/php/conf.d/
RUN rm /usr/local/etc/php/conf.d/php-fpm.ini