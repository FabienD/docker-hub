#
# Python custom image
#

ARG PYTHON_VER=3.9

FROM python:${PYTHON_VER}-slim-buster

LABEL maintainer="fabien@myprod.net"

# OS utilities & dependancies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        file \
        gnupg \
        htop \
        curl \
        git \
        ssh \
        tini \
        # necessary for pg => ld -lcrypto and ls -lssl
        libssl-dev \
     	# necessary for pg => ld -lz
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Postgresql 
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-contrib-9.6 \
        postgresql-server-dev-9.6 \
        postgresql-pltcl-9.6 \
    	# we use plpython3u and plpythonu extension so we've to install both
        postgresql-plpython3-9.6 \
        postgresql-plpython-9.6 \
        postgresql-9.6-ip4r \
        pgxnclient \
    && pgxn install temporal_tables \
    && pgxn install url_encode \
    && pgxn install pg_repack \
    && rm -rf /var/lib/apt/lists/*    

# Python 3 default libraries
RUN pip install virtualenv --no-cache-dir -U pip

# Add USER and APP dir
RUN useradd myprod --uid ${DOCKER_USER_ID:-1000} -m -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR:-/var/www/} \
    && echo 'export PS1=" 🐍 ${PYTHON_VERSION} | \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"' >> /home/myprod/.bashrc
    
WORKDIR ${APP_BASE_DIR:-/var/www/}

# Entrypoint & Cmd
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["python"]