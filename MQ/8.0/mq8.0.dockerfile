
#build
#  docker build -t mq8.0 . -f mq8.0.dockerfile
#run
#  docker run -d --name <name> -p <port>:1414 -v $(pwd)/<dir>:/var/mqm --env <MQ's name> mq8.0
#  docker run -d --name mq-8.0 -p 51414:1414 -v $(pwd)/data:/var/mqm mq8.0
#
#

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

RUN yum install -y bc && rm -rf /var/lib/apt/lists/

ENV IMG_TAG=IBMMQ_8.0 \
    INST_MQ=WS_MQ_LINUX_ON_X86_64_V8.0_IMG.tar.gz
   

ADD assets /zip

RUN chmod ug+x /zip/install.sh && /zip/install.sh

EXPOSE 1414

VOLUME  /var/mqm 

ENTRYPOINT ["/entrypoint.sh"]

CMD ["run"]