#build  
#docker build -t test2:1.0 . -f test2.dockerfile
#docker run -ti test2:1.0

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

RUN mkdir -p /workspace
ADD test.sh /workspace/
RUN chmod a+x /workspace/test.sh

ENV TEST_HOME /workspace

CMD ["/workspace/test.sh","/bin/bash"]



