#!bin/sh
cd /var/www/html

# download the WP-CLI (WordPress Command Line Interface) using curl
# the -O options saves the file with its original name
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# make the file executable
chmod +x wp-cli.phar

# move the wp-cli.phar file to /usr/local/bin/  and rename it to wp
# so it can be used as a command-line tool system-wide
mv wp-cli.phar /usr/local/bin/wp

# use the wp command to download the core wordpress files into the current directory(/var/www/html)
wp core download

# rename the default config-sample.php file to wp-config.php
# which is the main configuration file for wordpress
mv wp-config-sample.php wp-config.php

# replace placeholders in wp-config.php with actual environment variables (DB_NAME, DB_PASS, WP_USER)
sed -i "s/database_name_here/$DB_NAME/1" wp-config.php
sed -i "s/username_here/$WP_USER/1" wp-config.php
sed -i "s/password_here/$DB_PASS/1" wp-config.php

# replace localhost with mariadb in wp-config.php (mariadb refers to the service name in the docker-compose file)
sed -i "s/localhost/mariadb/1" wp-config.php

# use WP-CLI to install wordpress with specific settings:
# --url=$DOMAIN_NAME: the URL where the wordpress will be accessible
# --title=$WP_USER: the title of wordpress site
# --admin_user=$WP_USER: the wordpress admin username
# --admin_password=$DB_PASS: the wordpress admin password
# --admin_email=$WP_ADMIN_EMAIL: the wordpress admin email
# --skip-email: skip sending a confirmation email to the admin
# --allow-root: allow the commmand to run as root user
wp core install --url=$DOMAIN_NAME --title=$WP_USER --admin_user=$WP_USER --admin_password=$DB_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# use WP-CLI to create a new user with the role of author
# $DB_USER: is the username, and $WP_USER_EMAIL: is the email address associated with this user
# the user's password is set to $DB_PASS
wp user create $DB_USER $WP_USER_EMAIL --role=author --user_pass=$DB_PASS --allow-root

# start PHP-FPM (FastCGI Process Manager) in the foreground (-F) and allow the root to run it (-R)
/usr/sbin/php-fpm7 -F -R
