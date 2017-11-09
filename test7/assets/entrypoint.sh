#!/bin/bash

function rename_rabbitmq(){
    cp -rf /home/rabbitmq/rabbitmq_server-3.6.11 /usr/local
    cd /usr/local/
    mv rabbitmq_server-3.6.11 rabbitmq-3.6.11  
}

function config_rabbitmq(){
    cd ./rabbitmq-3.6.11/sbin
    ./rabbitmq-plugins enable rabbitmq_management
    sed -i '/#!/a\ERLANG_HOME=/usr/local/erlang' ./rabbitmq-server
    sed -i '/#!/a\exportPATH=$ERLANG_HOME/bin:$PATH' ./rabbitmq-server
    sed -i '/#!/a\ERLANG_HOME=/usr/local/erlang' ./rabbitmqctl
    sed -i '/#!/a\exportPATH=$ERLANG_HOME/bin:$PATH' ./rabbitmqctl

    ./rabbitmq-server
    ./rabbitmq-server -detached
    ./rabbitmqctl stop
}

function add_user (){
    cd /usr/local/rabbitmq-3.6.11/sbin
    ./rabbitmqctl add_user test 123456
    ./rabbitmqctl set_user_tags test administrator
    ./rabbitmqctl set_permissions -p "/" test ".*" ".*" ".*"
}

function install_erlang(){
    cd /home/erlang/otp_src_19.0 \
    ./configure --prefix=/usr/local/erlang --with-ssl -enable-threads -enable-smmp-support -enable-kernel-poll --enable-hipe --without-javac \
    make && make install
}

install_erlang
rename_rabbitmq
config_rabbitmq
add_user