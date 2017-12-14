#
# PHP 7.2-dev FPM image
#

FROM myprod/php:7.2

MAINTAINER Fabien D. <fabien@myprod.net>

# Xdebug install
RUN curl -fsSL 'https://github.com/xdebug/xdebug/archive/XDEBUG_2_6_0alpha1.zip' -o xdebug.zip \
    && unzip xdebug.zip \
    && ( \
        cd xdebug-XDEBUG_2_6_0alpha1 \
        && phpize \
        && ./configure --enable-xdebug \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xdebug-XDEBUG_2_6_0alpha1 \
    && docker-php-ext-enable xdebug

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/