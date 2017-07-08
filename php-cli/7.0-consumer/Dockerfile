#
# PHP 7.0.x Cli image with rabbitmq-cli-consumer (go)
#
# @see https://github.com/ricbra/rabbitmq-cli-consumer
#

FROM myprod/php:7.0-cli

MAINTAINER Fabien D. <fabien@myprod.net>

ADD https://github.com/ricbra/rabbitmq-cli-consumer/releases/download/1.4.2/rabbitmq-cli-consumer-linux-amd64.tar.gz /usr/local/bin/rabbitmq-cli-consumer-linux-amd64.tar.gz

RUN cd /usr/local/bin && tar -xzvf rabbitmq-cli-consumer-linux-amd64.tar.gz && chmod u+x rabbitmq-cli-consumer