FROM ghcr.io/automattic/vip-container-images/php-fpm:8.0

RUN apk add --no-cache git nginx
RUN wget -q https://getcomposer.org/installer -O - | php -- --install-dir=/usr/bin/ --filename=composer
COPY default.conf /etc/nginx/http.d/default.conf
