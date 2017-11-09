#!/bin/bash
function create_record(){
    echo "start create record"
    cd /workspace
    touch record
    echo "create record finish"
    echo "test2:1.0 is running" >> /workspace/record
}

if [ -e "$TEST_HOME/record" ];then
   echo "exit record"
else
   create_record
fi

exec "$@"