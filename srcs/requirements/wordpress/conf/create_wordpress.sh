#!/bin/sh
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

wp core download

mv wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$DB_NAME/1" wp-config.php
sed -i "s/username_here/$WP_USER/1" wp-config.php
sed -i "s/password_here/$DB_PASS/1" wp-config.php
sed -i "s/localhost/mariadb/1" wp-config.php

wp core install --url=$DOMAIN_NAME --title=$WP_USER --admin_user=$WP_USER --admin_password=$DB_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

wp user create $DB_USER $WP_USER_EMAIL --role=author --user_pass=$DB_PASS --allow-root

/usr/sbin/php-fpm7 -F -R