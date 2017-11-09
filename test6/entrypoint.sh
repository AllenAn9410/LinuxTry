#!/bin/bash

function startTomcat(){
    cd /home/Tomcat/apache-tomcat-8.5.20/bin
    sh startup.sh
}

function tomcatLog (){
    cd /home/Tomcat/apache-tomcat-8.5.20/logs
    tail -f catalina.out
}

echo "start tomcat"
startTomcat
echo "tomcat started"
tomcatLog

