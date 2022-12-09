#
# PHP 8.2-dev FPM image
#

FROM myprod/php:8.2-fpm

LABEL maintainer="fabien@myprod.net"

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/3.2.0.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-3.2.0 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-3.2.0 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/
