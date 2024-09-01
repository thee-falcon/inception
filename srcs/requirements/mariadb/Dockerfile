FROM alpine:3.18

# the deafult port for MySQL/MariaDB.
EXPOSE 3306

# update the package list and install the mariadb and mariadb-client.
RUN apk update && apk add mariadb mariadb-client

# create the directory for MySQL runtime, set appropriate permissions and initialize the database.
RUN mkdir -p /run/mysqld; \
    chmod 777 /run/mysqld; \
    chown -R mysql:mysql /run/mysqld; \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql; \
    chmod 777 /var/lib/mysql; \
    chown -R mysql:mysql /var/lib/mysql

# modify the MariaDB configuration file to allow network access
RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf; \
    sed -i 's/bind-address/#bind-address/g' /etc/my.cnf.d/mariadb-server.cnf

# copy the script to creating the database and users into the container
COPY requirements/mariadb/conf/create_db.sh .

# run the creat_db.sh script as the container's entrypoint command
CMD ["sh", "create_db.sh"]