#
#build
#
#
#

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

ADD assets/rabbitmq-start.sh /usr/local/bin/

RUN  \
  yum -y install wget \
  wget -qO - https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
  chmod +x /usr/local/bin/rabbitmq-start.sh

ENV RABBITMQ_LOG_BASE /data/log 
ENV RABBITMQ_MNESIA_BASE /data/mnesia 

VOLUME ["/data/log","/data/mnesia"]

WORKDIR /data

EXPOSE 5672
EXPOSE 15672

CMD ["rabbitmq-start.sh"]