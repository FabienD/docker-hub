#
# Python custom image
#

ARG PYTHON_VER=3.8

FROM python:${PYTHON_VER}-slim-buster

LABEL maintainer="fabien@myprod.net"

# OS utilities & dependancies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        gnupg \
        htop \
        curl \
        git \
        ssh \
        tini \
    && rm -rf /var/lib/apt/lists/*

# Postgresql 
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*    

# Python 3 default libraries
RUN pip install virtualenv --no-cache-dir -U pip

# Add USER and APP dir
RUN usermod -u ${DOCKER_USER_ID:-1000} www-data \
    && mkdir -p ${APP_BASE_DIR:-/var/www/}

WORKDIR ${APP_BASE_DIR:-/var/www/}

# Entrypoint & Cmd
ADD ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["python"]