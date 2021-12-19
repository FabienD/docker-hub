#
# PHP 8.0-dev FPM image
#

FROM myprod/php:8.0-fpm

MAINTAINER Fabien D. <fabien@myprod.net>

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/3.1.2.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-3.1.2 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-3.1.2 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/
