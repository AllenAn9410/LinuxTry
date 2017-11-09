#!/bin/bash

umask 0000

DB_NAME=${DB_NAME:-"EEDB"}
pid=0

function log {
    echo -e $(date '+%Y-%m-%d %T')"\e[1;32m $@\e[0m"
}

function stop_db2 {
    log "stopping database engine"
    db2stop force
}

function start_db2 {
    log "starting database engine"
    db2start
}

function create_db {
    echo "start db2..."
    mkdir -p $DB2_DATADIR
    chown db2inst1:db2iadm1 $DB2_DATADIR
    db2start
    sleep 3
    echo "create db ...$(whoami) $DB_NAME on $DB2_DATADIR "
    if [ -f /data/data_init.sh ]; then
      source /data/db2_init.sh -s
    fi
    echo "db2 init ok $(date '+%Y-%m-%d %T')" >> ${DB2_DATADIR}/db2_init

}

#
# main
#
trap "stop_db2" SIGTERM
trap "start_db2" SIGUSR1

echo "0 ${HOSTNAME} 0" >/home/db2inst1/sqllib/db2nodes.cfg

cat /home/db2inst1/sqllib/db2nodes.cfg

source /home/db2inst1/sqllib/db2profile

if [ -f "$DB2_DATADIR/db2_init" ]; then
 echo "exist DB"
else
 create_db
fi 

if [ "$1" = 'run' ]; then
  log "Initializing container"
  start_db2
  log "Database db2diag log following"
  tail -f ~db2inst1/sqllib/db2dump/db2diag.log &
  if [ -f /data/db2_runtime.sh ]; then
    source /data/db2_runtime.sh -s
  fi
  
  export pid=${!}
  while true
  do
    sleep 10000 &
    export spid=${!}
    wait $spid
  done
else
  exec "$1"
fi


