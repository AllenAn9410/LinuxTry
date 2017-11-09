#!/bin/bash

echo root:root | chpasswd 

mv /zip/entrypoint.sh /entrypoint.sh
chmod a+x /entrypoint.sh

groupadd db2iadm1
groupadd db2fadm1
groupadd dasadm1

useradd -g db2iadm1 -m -d /home/db2inst1 db2inst1
useradd -g db2fadm1 -m -d /home/db2fenc1 db2fenc1
useradd -g dasadm1 -m -d /home/dasusr1 dasusr1

echo db2inst1:db2inst1 | chpasswd
echo db2fenc1:db2fenc1 | chpasswd
echo dasusr1:dasusr1 | chpasswd

mkdir -p /tmp/db2 
tar -zxf /zip/$INST_DB2 -C /tmp/db2/
rm /zip/$INST_DB2
mv /etc/redhat-release /etc/redhat-rls
cd /tmp/db2/server_ese_u
./db2prereqcheck
./db2setup -r /zip/db2ese11.1.rsp
su - db2inst1 -c "source /home/db2inst1/sqllib/db2profile && db2licm -a /zip/db2ese11.1.lic"
mv /etc/redhat-rls /etc/redhat-release
cd /
rm -Rf /tmp/db2/
rm /zip/db2ese11.1.rsp

echo "install ok"