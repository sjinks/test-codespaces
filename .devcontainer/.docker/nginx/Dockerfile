FROM ghcr.io/automattic/vip-container-images/nginx:1.23.3

RUN apk add --no-cache git
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
