#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export MYSQL_DIR="${MYSQL_DIR:-/var/lib/mysql}"
export MYSQL_CONF_DIR="${MYSQL_CONF_DIR:-/etc/mysql}"
export MYSQL_SOCK_DIR="${MYSQL_SOCK_DIR:-/run/mysqld}"
export MYSQL_USER="${APP_USER}"
export MYSQL_GROUP="${APP_GROUP}"

mkdir -p "${MYSQL_DIR}"
mkdir -p "${MYSQL_CONF_DIR}"
mkdir -p "${MYSQL_SOCK_DIR}"
mkdir -p "${MYSQL_CONF_DIR}/conf.d"

if [ ! -d "${MYSQL_DIR}/mysql" ]; then
    mysql_install_db --user=${MYSQL_USER}
fi

if [ -f "${MYSQL_CONF_DIR}/my.cnf" ]; then
	echo "" >> "${MYSQL_CONF_DIR}/my.cnf"
	echo "!includedir ${MYSQL_CONF_DIR}/conf.d" >> "${MYSQL_CONF_DIR}/my.cnf"
fi

chown -R ${MYSQL_USER}:${MYSQL_GROUP} ${MYSQL_DIR}
chown -R ${MYSQL_USER}:${MYSQL_GROUP} ${MYSQL_CONF_DIR}
chown -R ${MYSQL_USER}:${MYSQL_GROUP} ${MYSQL_SOCK_DIR}
