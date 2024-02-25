FROM dunglas/frankenphp:latest-php8.2

# install the PHP extensions we need (https://make.wordpress.org/hosting/handbook/handbook/server-environment/#php-extensions)
RUN install-php-extensions \
    bcmath \
    exif \
    gd \
    intl \
    mysqli \
    zip \
    imagick \
    opcache

COPY --from=wordpress /usr/local/etc/php/conf.d/* /usr/local/etc/php/conf.d/
COPY --from=wordpress /usr/local/bin/docker-entrypoint.sh /usr/local/bin/
COPY --from=wordpress --chown=root:root /usr/src/wordpress /usr/src/wordpress

WORKDIR /var/www/html
VOLUME /var/www/html

RUN sed -i \
    -e 's/\[ "$1" = '\''php-fpm'\'' \]/\[\[ "$1" == su* \]\]/g' \
    -e 's/php-fpm/su/g' \
    /usr/local/bin/docker-entrypoint.sh

RUN sed -i \
    -e 's#root \* public/#root \* /var/www/html/#g' \
    /etc/caddy/Caddyfile

RUN echo "frankenphp run --config /etc/caddy/Caddyfile" > /start.sh; \
    chown -R www-data:www-data /data/caddy

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["su", "-s", "/bin/sh", "www-data", "/start.sh"]
