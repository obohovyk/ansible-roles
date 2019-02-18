#!/bin/bash

PARAM=$1
HOST=${2:-localhost}
PORT=27017
AUTH=false
USER=
PASS=

index=$( echo $PARAM | tr " " "." )

if [ $AUTH == "true" ]; then
    status=$(echo "db.serverStatus().${index}" |mongo -u ${USER} -p ${PASS} admin --port ${PORT}| sed -n '3p')
else
    status=$(echo "db.serverStatus().${index}" |mongo --port ${PORT}| sed -n '3p')
fi

if [[ "$status" =~ "NumberLong"   ]]; then
    echo $status| sed -n 's/NumberLong(//p'|sed -n 's/)//p'
else
    echo $status
fi
