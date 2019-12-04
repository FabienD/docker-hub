#
# PHP 7.1.x Cli image with rabbitmq-cli-consumer (go)
#
# @see https://github.com/ricbra/rabbitmq-cli-consumer
#

FROM myprod/php:7.1-cli

MAINTAINER Fabien D. <fabien@myprod.net>

ADD https://github.com/corvus-ch/rabbitmq-cli-consumer/releases/download/2.3.3/rabbitmq-cli-consumer_2.3.3_linux_amd64.tar.gz /usr/local/bin/rabbitmq-cli-consumer-linux-amd64.tar.gz

RUN cd /usr/local/bin && tar -xzvf rabbitmq-cli-consumer-linux-amd64.tar.gz && chmod u+x rabbitmq-cli-consumer