apt-get update && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        libicu-dev \
        libxml2-dev \
        libxslt-dev \
        libssh2-1-dev \
        libonig-dev \
        libmagickwand-dev \
        libmemcached-dev \
        ssh \
        git \
        unzip \
        ca-certificates \
        gnupg \
        wget \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl "https://www.postgresql.org/media/keys/ACCC4CF8.asc" | apt-key add - \
    && apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install -a apcu-5.1.23 \
    && pecl install -a imagick-3.7.0 \
    && pecl install -a grpc-1.60.0 \
    && pecl install -a protobuf-3.25.1 \
    && pecl install -a redis-6.0.2 \
    && pecl install -a memcached-3.2.0 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
    && docker-php-ext-install -j$(nproc) gd opcache mbstring \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql pgsql \
    && docker-php-ext-install zip bcmath intl exif xsl sockets \
    && docker-php-ext-enable apcu imagick grpc protobuf redis memcached