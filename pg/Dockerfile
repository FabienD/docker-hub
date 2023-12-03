ARG PG_VERSION

FROM debian:bookworm-slim as replibyte

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl wget jq

# Install Replibyte
RUN curl -s https://api.github.com/repos/Qovery/replibyte/releases/latest | \
    jq -r '.assets[].browser_download_url' | \
    grep -i 'linux-musl.tar.gz$' | wget -qi - \
    && tar zxf *.tar.gz \ 
    && chmod +x replibyte \
    && mv replibyte /usr/local/bin/


FROM timescale/timescaledb:latest-pg${PG_VERSION} as timescaledb

COPY --from=replibyte /usr/local/bin/replibyte /usr/local/bin/replibyte


FROM postgres:${PG_VERSION} as postgresql

COPY --from=replibyte /usr/local/bin/replibyte /usr/local/bin/replibyte