FROM dunglas/frankenphp

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
COPY --from=wordpress --chown=www-data:www-data /usr/src/wordpress /app/public
COPY /app/public/wp-config-docker.php /app/public/wp-config.php

VOLUME /var/www/html

RUN sed -i 's/php-fpm/frankenphp run/g' /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["frankenphp", "run", "--config", "/etc/Caddyfile"]
