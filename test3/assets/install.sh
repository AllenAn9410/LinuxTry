#!/bin/bash
chmod 755 /entrypoint.sh

groupadd --gid 1000 mqm 

mkdir -p /data/init

echo "install ok."