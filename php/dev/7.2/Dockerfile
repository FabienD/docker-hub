#
# PHP 7.2-dev FPM image
#

FROM myprod/php:7.2

LABEL maintainer="fabien@myprod.net"

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/2.9.4.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-2.9.4 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-2.9.4 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/