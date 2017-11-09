#!/bin/bash

if [ ! -f /firstrun ]; then
   PASS=`pwgen -s 12 1`
   cat >/etc/rabbitmq/rabbitmq.config <<EOF
   [
       {rabbit,[{default_user,<<"admin">>},{default_pass,<<"$PASS">>}]}
   ].
EOF

 echo "set default user = admin and default password = $PASS"
 (sleep 10 && rabbitmqctl add_vhost $DEVEL_VHOST_NAME && rabbitmqctl set_permissions -p $DEVEL_VHOST_NAME admin ".*" ".*" ".*") &

	touch /firstrun
fi

exec /usr/sbin/rabbitmq-server
