FROM alpine:3.14

EXPOSE 9000

# update the package list and install PHP 7, PHP-FPM (FastCGI Process Manager),
# PHP extensions (mysqli, phar), curl, and composer (a dependency manager for PHP)
RUN apk update && apk add php7 \
    php7-fpm \
    php7-mysqli \
    php7-phar \
    curl \
    composer \
    && sed -i "s|listen = 127.0.0.1:9000|listen =9000|g" /etc/php7/php-fpm.d/www.conf

COPY requirements/wordpress/conf/create_wordpress.sh .

RUN mkdir -p /var/www/html

# set the working directory to /var/www/html, where the WordPress will be installed
WORKDIR /var/www/html

CMD ["sh", "/./create_wordpress.sh"]