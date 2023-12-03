ARG NODE_VERSION
ARG APP_BASE_DIR=/var/www
ARG DOCKER_UID=1000
ARG DOCKER_GID=1000

FROM node:${NODE_VERSION} as main

ARG APP_BASE_DIR
ARG DOCKER_UID
ARG DOCKER_GID

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add USER and APP dir
RUN groupadd dockeruser --gid ${DOCKER_GID} --no-unique \
    && useradd dockeruser --uid ${DOCKER_UID} --gid ${DOCKER_GID} --no-unique -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR} \
    && echo 'export PS1=" 💩 ${NODE_VERSION} | \[\033[1;37m\]\h \[\033[1;33m\]\W\[\033[0;38m\] \[\033[1;37m\]# \[\033[0m\]"' >> /home/dockeruser/.bashrc

WORKDIR ${APP_BASE_DIR}
