FROM alpine:3.14

EXPOSE 3306

RUN apk update && apk add mariadb mariadb-client

RUN mkdir -p /run/mysqld; \
    chmod 777 /run/mysqld; \
    chown -R mysql:mysql /run/mysqld; \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql; \
    chmod 777 /var/lib/mysql; \
    chown -R mysql:mysql /var/lib/mysql

RUN sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf; \
    sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

COPY requirements/mariadb/conf/create_db.sh .

CMD ["sh", "create_db.sh"]