#!/bin/bash

# setup client
MYSQL_SLAVE_CLIENT="mysql -u${REPLICATION_USER} -p${REPLICATION_PASSWORD}"

# stop slave
echo "stop slave; reset slave; reset master;" | $MYSQL_SLAVE_CLIENT

# stop mariadb
sudo supervisorctl stop mariadb

# copy data (use rsync instead?)
scp -rpP ${SSH_PORT} ${REPLICATION_MASTER}:/var/lib/mysql/* /var/lib/mysql/
rm -f /var/lib/mysql/master*

# start mariadb
sudo supervisorctl start mariadb

cat /etc/mysql/init.sql | $MYSQL_SLAVE_CLIENT

