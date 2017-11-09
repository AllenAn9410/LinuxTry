#!/bin/bash

set -e
MQ_QMGR_NAME=${MQ_QMGR_NAME:-"MQQMGR"}

function log {
 echo -e $(date '+%Y-%m-%d %T')"\e[1;32m $@\e[0m"
}

function start { 
  log "starting MQ"
  : ${MQ_QMGR_NAME?"ERROR:You need to set the MQ_QMGR_NAME envirnment variable"}
  source /opt/mqm/bin/setmqenv -s
  echo "----------------------------------------"
  dspmqver
  echo "----------------------------------------"

  QMGR_EXISTS=`dspmq | grep ${MQ_QMGR_NAME} > /dev/null ; echo $?`
  if [ ${QMGR_EXISTS} -ne 0 ]; then
    echo "checking filesystem..."
    amqmfsck /var/mqm
    echo "----------------------------------------"
    crtmqm -q ${MQ_QMGR_NAME} || true
    if [ ${MQ_QMGR_CMDLEVEL+x} ]; then
      strmqm -e CMDLEVEL=${MQ_QMGR_CMDLEVEL} || true
    fi
   echo "----------------------------------------"
  fi
  strmqm ${MQ_QMGR_NAME}
    if [ ${QMGR_EXISTS} -ne 0 ]; then 
      echo "----------------------------------------"
      if [ -f /zip/listener.mqsc ]; then
        runmqsc ${MQ_QMGR_NAME} <<EOF
        ALTER LISTENER('SYSTEM.DEFAULT.LISTENER.TCP') TRPTYPE(TCP) PORT(1414) CONTROL(QMGR)
        START LISTENER('SYSTEM.DEFAULT.LISTENER.TCP')
EOF
      fi
      if [ -f /var/mqm/mq_init.sh ]; then
        source /var/mqm/mq_init.sh -s 
      fi
    fi
    echo "----------------------------------------"
  if [ -f /var/mqm/mq_runtime.sh ]; then
    source /var/mqm/mq_runtime.sh -s
  fi
}

function stop {
  log "stopping MQ"
  endmqm $MQ_QMGR_NAME
}

function monitor {
  log "starting monitor"
  until [ "`state`" == "RUNNING" ]; do
    sleep 1
  done
  dspmq

  until [ "`state`" != "RUNNING" ]; do
    sleep 5
  done

  while true ; do
    STATE=`state`
    case "$STATE" in 
      ENDED*) break;;
      *);;
    esac
    sleep 1
  done
  dspmq

}

function state {
  dspmq -n -m ${MQ_QMGR_NAME} | awk -F '[()]' '{ print $4 }'
}

#
#
#
#
log "start run"
if [ !"$(ls -A /var/mqm)" ]; then
  /opt/mqm/bin/amqicdir -i -f
fi
start
trap stop SIGTERM SIGINT
monitor