#
# Filebeat image
#

FROM prima/filebeat

MAINTAINER Fabien D. <fabien@myprod.net>

COPY filebeat.yml /filebeat.yml

RUN mkdir -p ${APP_BASE_DIR:-/var/www/app/logs/}