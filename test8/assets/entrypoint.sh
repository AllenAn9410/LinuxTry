#!/bin/bash
  
function install_erlang(){
    cd /workspace/erlang/otp_src_19.0 \
    ./configure --prefix=/usr/local/erlang --with-ssl -enable-threads -enable-smmp-support -enable-kernel-poll --enable-hipe --without-javac \
    make && make install
}

function configure_rabbitmq(){
    cd /usr/local/rabbitmq-3.6.11/sbin
     ./rabbitmq-plugins enable rabbitmq_management
    ./rabbitmq-server
    ./rabbitmq-server -detached
    ./rabbitmqctl stop
}

function add_user(){
    cd /usr/local/rabbitmq-3.6.11/sbin
    ./rabbitmqctl add_user test 123456
    ./rabbitmqctl set_user_tags test administrator
    ./rabbitmqctl set_permissions -p "/" test ".*" ".*" ".*" 
}

install_erlang
configure_rabbitmq
add_user 