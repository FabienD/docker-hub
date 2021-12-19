#
# PHP 8.1.x-blackfire FPM image
#

FROM myprod/php:8.1-fpm

LABEL maintainer="fabien@myprod.net"

# BlackFire install
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket='tcp://blackfire:8707'" > $PHP_INI_DIR/conf.d/blackfire.ini

# PHP Application configuration (php.ini override)
ADD php-custom.ini /usr/local/etc/php/conf.d/