#!/bin/bash

export APP_USER="${APP_USER:-cyclops}"
export APP_GROUP="${APP_GROUP:-${APP_USER}}"
export MYSQL_DIR="${MYSQL_DIR:-/var/lib/mysql}"
export MYSQL_CONF_DIR="${MYSQL_DIR:-/etc/mysql}"
export MYSQL_SOCK_DIR="${MYSQL_SOCK_DIR:-/run/mysqld}"

mkdir -p ${MYSQL_DIR}
mkdir -p ${MYSQL_CONF_DIR}
mkdir -p ${MYSQL_SOCK_DIR}

if [ ! -d "${MYSQL_DIR}/mysql" ]; then
    mysql_install_db --user=${APP_USER}
fi

chown -R ${APP_USER}:${APP_GROUP} ${MYSQL_DIR}
chown -R ${APP_USER}:${APP_GROUP} ${MYSQL_CONF_DIR}
chown -R ${APP_USER}:${APP_GROUP} ${MYSQL_SOCK_DIR}
