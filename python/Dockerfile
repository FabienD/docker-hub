ARG PYTHON_VERSION
ARG APP_BASE_DIR=/var/www
ARG DOCKER_UID=1000
ARG DOCKER_GID=1000

FROM python:${PYTHON_VERSION}-slim-bookworm as main

ARG APP_BASE_DIR
ARG DOCKER_UID
ARG DOCKER_GID

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
        libxslt-dev \
        libxml2-dev \
        # necessary for pg => ld -lcrypto and ls -lssl
        libssl-dev \
     	# necessary for pg => ld -lz
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Python 3 default libraries
RUN pip install bpython virtualenv jupyter poetry black --no-cache-dir -U pip

# Add USER and APP dir
RUN groupadd dockeruser --gid ${DOCKER_GID} \
    && useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} -m -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR} \
    && echo 'export PS1=" 🐍 ${PYTHON_VERSION} | \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"' >> /home/dockeruser/.bashrc
    
WORKDIR ${APP_BASE_DIR}

# Entrypoint & Cmd
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

CMD ["python"]