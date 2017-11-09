#build
#  docker build -t ese11.1:test . -f ese11.1.dockerfile
#run
#  docker run -it --rm --name db2.11.1 -v $(pwd)/data:/home/db2inst1/data -p 58888:50000 ese11.1:test bash
#
#

FROM centos:latest

MAINTAINER allen.an@chinasystems.com

RUN yum install -y pam pam.i686 ncurses-libs.i686 file libaio libstdc++-devel.i686 numactl-libs && \
    yum clean all

ENV IMG_TAG=IBMDB2_11.1.ESE \
    INST_DB2=DB2_ESE_AUSI_Svr_11.1_Linux_86-64.tar.gz \
    DB2_DIR=/opt/ibm/db2/V11.1 \
    DB2_DATADIR=/home/db2inst1/data 

ADD assets /zip

RUN chmod a+x /zip/install.sh && /zip/install.sh

VOLUME ["$DB2_DATADIR"]

EXPOSE 50000

USER db2inst1
WORKDIR /home/db2inst1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]


