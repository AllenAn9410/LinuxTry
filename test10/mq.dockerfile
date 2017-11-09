#build 
#docker build -t mq:test . -f mq.dockerfile
#docker run -d -name <> -p <> mq:test bin/bash
#
#
#

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

RUN yum isntall -y bc && rm -f /var/lib/apt/lists/

ARG URL=http://10.39.104.40/zip/imb/

ENV 

ADD assests /zip

RUN chmod ug+x