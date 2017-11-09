#build
#docker build -t test3:1.0 . -f test3Cent.dockerfile  
#docker run -ti test3:1.0 

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

COPY assets/entrypoint.sh /entrypoint.sh
COPY assets/install.sh /zip/
RUN mkdir -p /data
COPY assets/runtime.sh /data/

EXPOSE 8080

ENV HOST_HOME /root
WORKDIR $HOST_HOME

RUN chmod 755 /zip/install.sh

ENTRYPOINT ["/entrypoint.sh"]

