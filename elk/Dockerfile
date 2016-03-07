#
# ELK image
#

FROM willdurand/elk

MAINTAINER Fabien D. <fabien@myprod.net>

ADD logstash.conf /etc/logstash/
ADD patterns /opt/logstash/patterns

RUN mkdir -p ${APP_BASE_DIR:-/var/www/app/logs/}