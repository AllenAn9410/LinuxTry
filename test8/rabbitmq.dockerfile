#
#docker build -t rabbitmq:test2 . -f rabbitmq.dockerfile
#docker run -d --name rabbitmq-test2 -p 55555:55555 -p 55554:55554 rabbitmq:test2
#

FROM centos 

MAINTAINER allen.an@chinasystem.com

RUN yum -y install make gcc gcc-c++ kernel-devel m4 ncurses-devel openssl-devel

ADD assets /zip

RUN chmod a+x /zip/install.sh && /zip/install.sh

ENV ERLANG_HOME /workspace/erlang/otp_src_19.0
ENV PATH $ERLANG_HOME/bin:$PATH

EXPOSE 55555 
EXPOSE 55554

ENTRYPOINT ["/zip/entrypoint.sh"]