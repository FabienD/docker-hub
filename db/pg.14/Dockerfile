#
# PostgreSQL custom image
#   With TimescaleDB
#   With replibyte tool
# 

ARG PG_VER=14

FROM timescale/timescaledb:latest-pg${PG_VER}

LABEL maintainer="fabien@myprod.net"

# OS utilities & dependancies
RUN apk add --no-cache \
        htop \
        curl \
        wget \
        jq

# Install replibyte from archive
RUN curl -s https://api.github.com/repos/Qovery/replibyte/releases/latest | \
    jq -r '.assets[].browser_download_url' | \
    grep -i 'linux-musl.tar.gz$' | wget -qi - && \
    # unarchive
    tar zxf *.tar.gz && \
    # make replibyte executable
    chmod +x replibyte && \
    # make it accessible from everywhere
    mv replibyte /usr/local/bin/

