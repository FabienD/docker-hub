#
# PHP 7.0-dev FPM image
#

FROM myprod/php:7.0

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

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/