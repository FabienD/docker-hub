#
# Application image
#

FROM busybox
LABEL maintainer="fabien@myprod.net"

RUN mkdir -p ${APP_BASE_DIR:-/var/www/}
VOLUME ${APP_BASE_DIR:-/var/www/}