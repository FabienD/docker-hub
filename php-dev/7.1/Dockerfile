#
# PHP 7.1-dev FPM image
#

FROM myprod/php:7.1

MAINTAINER Fabien D. <fabien@myprod.net>

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/2.6.0.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-2.6.0 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-2.6.0 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/