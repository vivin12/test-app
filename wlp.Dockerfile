FROM adoptopenjdk/openjdk8-openj9 AS build-stage

COPY . /project
WORKDIR /project

RUN mkdir -p /config/apps && \
    mkdir -p /sharedlibs && \
    mkdir -p /config/lib && \
    cp ./src/main/liberty/config/server.xml /config && \
    cp ./src/main/resources/*.properties /config && \
    cp ./target/*.*ar /config/apps/

FROM ibmcom/websphere-liberty:kernel-java8-ibmjava-ubi

RUN mkdir -p /opt/ibm/wlp/usr/shared/config/lib/global
RUN mkdir -p /opt/ibm/wlp/usr/shared/resources
RUN mkdir -p /opt/ibm/wlp/usr/servers/defaultServer

RUN cat /config/server.xml
COPY --chown=1001:0 --from=build-stage /config/ /config/

USER root
RUN configure.sh
USER 1001