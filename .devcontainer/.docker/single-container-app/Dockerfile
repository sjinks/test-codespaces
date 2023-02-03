FROM alpine:3.16

RUN \
    echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --no-cache runit nginx ca-certificates curl tar xz openssl less bash memcached su-exec git jq icu-data-full \
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
        php8-zip \
        nodejs npm \
        github-cli \
        phpmyadmin

RUN ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm

RUN adduser -u 82 -D -S -G www-data www-data
RUN /usr/bin/mysql_install_db --auth-root-authentication-method=normal --skip-test-db --user=mysql --datadir=/var/lib/mysql

RUN \
    wget -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod 0755 /usr/local/bin/wp && \
    wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer

RUN wget -q https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 -O /usr/local/bin/mailhog && chmod 0755 /usr/local/bin/mailhog

ADD root/ /

ENV WP_CLI_CONFIG_PATH /etc/wp-cli/wp-cli.yaml
ENV WP_CLI_ALLOW_ROOT 1
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_INI_DIR /etc/php8

RUN \
    wp core download --path=/wp && \
    cd /tmp && \
    git clone --depth=1 https://github.com/Automattic/vip-container-images.git && \
    cp -aR vip-container-images/dev-tools / && \
    cp -aR vip-container-images/wordpress/extra/* /wp/ && \
    sed -i 's/memcached:11211/127.0.0.1:11211/' /dev-tools/wp-config.php.tpl && \
    rm -rf /dev-tools/Dockerfile /dev-tools/scripts /tmp/vip-container-images && \
    rm -rf /wp/wp-content/mu-plugins/.nodelete && \
    git clone --depth=1 https://github.com/Automattic/vip-go-mu-plugins-built.git /wp/wp-content/mu-plugins && \
    rm -rf /wp/wp-content/mu-plugins/.git && \
    install -d -m 0777 -o www-data -g www-data /usr/share/webapps/phpmyadmin/tmp && \
    chmod 0664 /etc/phpmyadmin/config.inc.php

RUN npm i -g @automattic/vip

EXPOSE 80
ENTRYPOINT ["/sbin/runsvdir", "-P", "/etc/service"]
