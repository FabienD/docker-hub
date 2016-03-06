# PHP 5.6.x-dev FPM Container
#
# Version 1.0

FROM myprod/php:5.6

MAINTAINER Fabien D. <fabien@myprod.net>

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/XDEBUG_2_4_0.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-XDEBUG_2_4_0 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-XDEBUG_2_4_0 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override + FPM pool configuration)
ADD php-custom.ini /usr/local/etc/php/conf.d/