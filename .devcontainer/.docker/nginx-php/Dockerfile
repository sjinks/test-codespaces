FROM alpine:3.16

RUN \
    echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache runit nginx ca-certificates curl tar xz openssl less bash memcached mariadb mariadb-client su-exec shadow git jq icu-data-full php8 php8-fpm php8-pear \
        php8-pecl-apcu \
        php8-bcmath \
        php8-calendar \
        php8-ctype \
        php8-curl \
        php8-dom \
        php8-exif \
        php8-fileinfo \
        php8-ftp \
        php8-gd \
        php8-pecl-gmagick@testing \
        php8-gmp \
        php8-iconv \
        php8-intl \
        php8-json \
        php8-mbstring \
        php8-pecl-mcrypt \
        php8-pecl-memcache \
        php8-pecl-memcached \
        php8-mysqli \
        php8-mysqlnd \
        php8-opcache \
        php8-openssl \
        php8-pcntl \
        php8-pdo \
        php8-pdo_sqlite \
        php8-phar \
        php8-posix \
        php8-session \
        php8-shmop \
        php8-simplexml \
        php8-soap \
        php8-sockets \
        php8-sodium \
        php8-sqlite3 \
        php8-pecl-ssh2 \
        php8-sysvsem \
        php8-sysvshm \
        php8-pecl-timezonedb \
        php8-tokenizer \
        php8-pecl-xdebug \
        php8-xml \
        php8-xmlreader \
        php8-xmlwriter \
        php8-zip

RUN ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm

RUN adduser -u 82 -D -S -G www-data www-data
RUN /usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql

RUN \
    wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod 0755 /usr/local/bin/wp && \
    wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer

ADD root/ /

ENV WP_CLI_CONFIG_PATH /config/wp-cli.yaml
ENV WP_CLI_ALLOW_ROOT 1

RUN \
    wp core download --path=/wp && \
    cd /tmp && \
    git clone --depth=1 https://github.com/Automattic/vip-container-images.git && \
    cp -aR vip-container-images/dev-tools / && \
    cp -aR vip-container-images/wordpress/extra/* /wp/ && \
    sed -i 's/memcached:11211/127.0.0.1:11211/' /dev-tools/wp-config.php.tpl && \
    rm -rf /dev-tools/Dockerfile /dev-tools/scripts /tmp/vip-container-images && \
    touch /wp/wp-content/mu-plugins/000-vip-init.php

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
