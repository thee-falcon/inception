#!/bin/bash
echo "CREATE DATABASE $DB_NAME ;" > database.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$WP_USER'@'%' IDENTIFIED BY '$DB_PASS';" >> database.sql
echo "FLUSH PRIVILEGES;" >> database.sql

mysqld --user=mysql --init-file=/database.sql
