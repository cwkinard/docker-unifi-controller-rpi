FROM resin/rpi-raspbian:jessie
MAINTAINER Will Kinard "wilsonkinard@gmail.com"


RUN apt-get -y update && \
    apt-get install -y openjdk-7-jre \ 
		       wget \
		       unzip

RUN mkdir /opt/mongo
ADD mongodb-rpi/mongo /opt/mongo
RUN chmod +x /opt/mongo/bin/*
RUN mkdir /data/ && mkdir /data/db/

RUN export PATH=$PATH:/opt/mongo/bin/

RUN cd /opt/ && sudo wget http://dl.ubnt.com/unifi/4.8.18/UniFi.unix.zip && \
    unzip UniFi.unix.zip

RUN cd /opt/UniFi/bin && \
    ln -fs /opt/mongo/bin/mongod mongod

EXPOSE 8443 8843 8880 8080 3478 27117

CMD ["java", "-jar", "/opt/UniFi/lib/ace.jar", "start", "&"]
