#!/bin/bash
mv /zip/entrypoint.sh /entrypoint.sh
chmod ug+x  /entrypoint.sh

mkdir -p /tmp/mqm

groupadd --gid 1000 mqm
useradd --uid 1000 --gid mqm --home-dir /var/mqm mqm
usermod -G mqm root
echo mqm:mqm | chpasswd
echo root:root | chpasswd

mkdir -p /tmp/mqm
mv /zip/$INST_MQ /tmp/mqm
tar -xzvf /tmp/mqm/$INST_MQ -C /tmp/mqm
cd /tmp/mqm
./mqlicense.sh -text_only -accept
rpm -ivh MQSeriesRuntime-8.0.0-0.x86_64.rpm MQSeriesServer-8.0.0-0.x86_64.rpm
/opt/mqm/bin/setmqinst -p /opt/mqm -i 
rm -rf /tmp/mqm
 
echo "install ok"