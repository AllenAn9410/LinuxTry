#build
#docker build -t dockerfile:1.0 . -f test1.dockerfile
#docker run -ti dockerfile:1.0

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

ADD hello.sh /hello.sh

RUN mkdir -p /cache/test
RUN touch /cache/test/record

CMD ["/hello.sh"]