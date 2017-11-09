#!/bin/bash
if [ -f /var/mqm/eemq_init.mqsc ]; then 
  echo "init starting.."
  runmqsc ${MQ_QMGR_NAME} < /var/mqm/eemq_init.mqsc
else
  echo "cannot find /var/mqm/eemq_init.mqsc "
fi
