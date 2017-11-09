#!/bin/bash

HOST_NAME=${HOST_NAME:-"localhost"}

function log {
    echo -e $(date '+%Y-%m-%d %T')"\e[1;32m $@\e[0m"
}

config(){
    if [ -f /data/runtime.sh ];then
       source /data/runtime.sh
    fi
    echo "-- config -- ok "
}

stop(){
    echo "-- stop"
}

start(){
    echo "start ok."
}

monitor(){
    log "monitor ok."
}

config
trap stop SIGTERM SIGINT
monitor

# /bin/bash 

exec "$@"