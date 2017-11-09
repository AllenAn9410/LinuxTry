#
#build
#docker build -t rabbitmq:test . -f rabbitmq.dockerfile
#docker run -d --name rabbitmq-test -p 55555:55555 -p 55554:55554 rabbitmq:test /usr/local/rabbitmq-3.6.11/sbin/rabbitmq-server

FROM centos

MAINTAINER allen.an@chinasystems.com

RUN yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel

COPY /assets/entrypoint.sh .

#install Erlang 
#download from http://erlang.org/download/
COPY assets/otp_src_19.0.tar.gz /home/
RUN mkdir -p /home/erlang
RUN tar zxf /home/otp_src_19.0.tar.gz -C /home/erlang && rm -rf /home/otp_src_19.0.tar.gz

ENV ERLANG_HOME /home/erlang/otp_src_19.0
ENV PATH $PATH:$ERLANG_HOME/bin

#install rabbitmq
COPY assets/rabbitmq-server-generic-unix-3.6.11.tar.gz /home/
RUN mkdir -p /home/rabbitmq
RUN tar xf /home/rabbitmq-server-generic-unix-3.6.11.tar.gz -C /home/rabbitmq && rm -rf /home/rabbitmq-server-generic-unix-3.6.11.tar.gz

WORKDIR /home

EXPOSE 55555 
EXPOSE 55554

ENTRYPOINT ["entrypoint.sh"]