FROM alpine:3.16

RUN \
    echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache runit nginx gettext ca-certificates curl tar xz openssl less bash su-exec git jq icu-data-full \
        mariadb mariadb-client \
        php8 php8-fpm php8-pear \
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
        php8-xml \
        php8-xmlreader \
        php8-xmlwriter \
        php8-zip \
        github-cli \
        sudo

ENV WP_CLI_ALLOW_ROOT 1
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_INI_DIR /etc/php8

# System
RUN \
    adduser -D -G www-data -s /bin/bash www-data && \
    echo 'www-data ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/www-data && \
    chmod 0440 /etc/sudoers.d/www-data

# PHP
RUN \
    ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm && \
    wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer

# WP-CLI
RUN wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod 0755 /usr/local/bin/wp

# WordPress
RUN wp core download --path=/wp --skip-content

# VIP Go mu-plugins
RUN \
    git clone --depth=1 https://github.com/Automattic/vip-go-mu-plugins-built.git /wp/wp-content/mu-plugins && \
    rm -rf /wp/wp-content/mu-plugins/.git

# nginx
RUN \
    sed -i 's/user nginx;/user www-data;/' /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /run/nginx /var/log/nginx

ADD root/ /

ENV WP_CLI_CONFIG_PATH /etc/wp-cli/wp-cli.yaml

# Dev Env Plugin
RUN cp /dev-tools/dev-env-plugin.php /wp/wp-content/mu-plugins/

WORKDIR /wp
# This does not work nicely with Codespaces - we cannot replace hese directories with symlinks
# VOLUME ["/wp/wp-content/uploads", "/var/lib/mysql"]
EXPOSE 80
ENTRYPOINT ["/sbin/runsvdir", "-P", "/etc/service"]
