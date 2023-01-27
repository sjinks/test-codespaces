FROM ghcr.io/automattic/vip-container-images/php-fpm:8.0

RUN apk add --no-cache git nginx
RUN wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer
COPY entrypoint.sh setup.sh /usr/local/bin/
COPY default.conf /etc/nginx/conf.d/default.conf

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
