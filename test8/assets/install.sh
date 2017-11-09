#!/bin/bash

function unzipfile (){
         mkdir -p /workspace/erlang
         mkdir -p /workspace/rabbitmq

        tar zxf /zip/otp_src_19.0.tar.gz -C /workspace/erlang
        rm -rf /zip/otp_src_19.0.tar.gz

        tar xf /zip/rabbitmq-server-generic-unix-3.6.11.tar.gz -C /workspace/rabbitmq
        rm -rf /zip/rabbitmq-server-generic-unix-3.6.11.tar.gz

        cp -rf /workspace/rabbitmq/rabbitmq_server-3.6.11 /usr/local
        cd /usr/local/
        mv rabbitmq_server-3.6.11 rabbitmq-3.6.11
}

unzipfile
echo "install OK"