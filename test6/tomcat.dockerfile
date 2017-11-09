#
#docker build -t tomcat:1.0 . -f tomcat.dockerfile
#docker run -d --name tomcat-test1 -p 58080:8080 -v /home/eeuser/image/test6/webapps:/home/Tomcat/apache-tomcat-8.5.20/webapps tomcat:1.0 /bin/bash 
#docker exec -it <container ID> bin/bash
#10.39.104.40:58080/test1/index.html

FROM centos

MAINTAINER allen.an@chinasystems.com

WORKDIR /home
ADD entrypoint.sh /home/

RUN mkdir JDK
COPY jdk-7u67-linux-x64.tar.gz /home/
RUN tar zxf /home/jdk-7u67-linux-x64.tar.gz -C /home/JDK && rm -rf /home/jdk-7u67-linux-x64.tar.gz

ENV JAVA_HOME /home/JDK/jdk1.7.0_67
ENV PATH $PATH:$JAVA_HOME/bin

RUN mkdir Tomcat 
COPY apache-tomcat-8.5.20.tar.gz /home/
RUN tar zxf /home/apache-tomcat-8.5.20.tar.gz -C /home/Tomcat && rm -rf /home/apache-tomcat-8.5.20.tar.gz

VOLUME ["/home/Tomcat/apache-tomcat-8.5.20/webapps"]

EXPOSE 8080

ENTRYPOINT ["/home/entrypoint.sh"]
CMD 
