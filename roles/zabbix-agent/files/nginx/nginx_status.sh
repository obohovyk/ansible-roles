#!/bin/bash

if [ -z $1 ]; then
  echo "[ERROR]: No argument found."
  exit 1
fi

METRIC=$1
HOST=${2:-localhost}
URL="http://${HOST}:10061/status"
CURL="/usr/bin/curl"

if [ $METRIC = "active" ]; then
    $CURL -s $URL | grep "Active connections" | awk {'print $3'}
fi
if [ "$METRIC" = "accepts" ]; then
    $CURL -s $URL | sed -n '3p' | cut -d" " -f2
fi
if [ "$METRIC" = "handled" ]; then
    $CURL -s $URL | sed -n '3p' | cut -d" " -f3
fi
if [ "$METRIC" = "requests" ]; then
    $CURL -s $URL | sed -n '3p' | cut -d" " -f4
fi
if [ "$METRIC" = "reading" ]; then
    $CURL -s $URL | grep "Reading" | cut -d':' -f2 | cut -d' ' -f2
fi
if [ "$METRIC" = "writing" ]; then
    $CURL -s $URL | grep "Writing" | cut -d':' -f3 | cut -d' ' -f2
fi
if [ "$METRIC" = "waiting" ]; then
    $CURL -s $URL | grep "Waiting" | cut -d':' -f4 | cut -d' ' -f2
fi
