FROM ghcr.io/automattic/vip-container-images/php-fpm:8.0

RUN apk add --no-cache git
RUN wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY zz-docker.conf /etc/php8/php-fpm.d/zz-docker.conf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
