#build 
#docker build -t rabbitmq:test3 . -f rabbitmq.dockerfile
#docker run -d --name rabbitmq-test3 -p 50001:50001 -p 50002:50002 rabbitmq:test3  
#
#

FROM centos

MAINTAINER allen.an@chinasystems.com

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install pwgen wget logrotater rabbitmq-server; yum clean all
RUN /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

ADD server.sh /server.sh
RUN chmod 750 ./server.sh

EXPOSE 50001 50002

ENV DEVEL_VHOST_NAME develop

CMD ["/server.sh"]