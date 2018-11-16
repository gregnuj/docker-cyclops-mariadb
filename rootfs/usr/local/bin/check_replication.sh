#!/bin/bash 

# setup client
MYSQL_CLIENT="mysql -u${REPLICATION_USER} -p${REPLICATION_PASSWORD} -E"
SQL="show slave status;"

# collect output and status
OUTPUT="$(echo $SQL | $MYSQL_CLIENT | tail -n+2 | awk -F '[: ]+' '{print $2 "=\"" $3 "\""}')"
for VAR in $OUTPUT; do
    eval "${VAR}"
done

# check for failure
STATUS=""
if [[ ${Slave_IO_Running} != 'Yes' ]]; then
    STATUS+="Slave_IO_Running: ${Slave_IO_Running}\n"
    STATUS+="Last_IO_Error: ${Last_IO_Error}\n"
fi
if [[ ${Slave_SQL_Running} != 'Yes' ]]; then
    STATUS+="Slave_SQL_Running: ${Slave_SQL_Running}\n"
    STATUS+="Last_SQL_Error: ${Last_SQL_Error}\n"
fi

# send email notification
if [[ -n "$STATUS" ]]; then
    printf "${STATUS}" 
fi

