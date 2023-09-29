#
# Python custom image
#

ARG PYTHON_VER=3.12-rc

FROM python:${PYTHON_VER}-slim-bookworm

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
        libxslt-dev \
        libxml2-dev \
        # necessary for pg => ld -lcrypto and ls -lssl
        libssl-dev \
     	# necessary for pg => ld -lz
        zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Python 3 default libraries
RUN pip install bpython virtualenv jupyter poetry black blackfire --no-cache-dir -U pip

# Blackfire.io
RUN mkdir -p /tmp/blackfire \
    && architecture=$(case $(uname -m) in i386 | i686 | x86) echo "i386" ;; x86_64 | amd64) echo "amd64" ;; aarch64 | arm64 | armv8) echo "arm64" ;; *) echo "amd64" ;; esac) \
    && curl -A "Docker" -L https://blackfire.io/api/v1/releases/cli/linux/$architecture | tar zxp -C /tmp/blackfire \
    && mv /tmp/blackfire/blackfire /usr/bin/blackfire \
    && rm -Rf /tmp/blackfire

# Add USER and APP dir
RUN useradd myprod --uid ${DOCKER_USER_ID:-1000} -m -s /bin/bash \
    && mkdir -p ${APP_BASE_DIR:-/var/www/} \
    && echo 'export PS1=" 🐍 ${PYTHON_VERSION} | \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]"' >> /home/myprod/.bashrc
    
WORKDIR ${APP_BASE_DIR:-/var/www/}

# Entrypoint & Cmd
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["python"]