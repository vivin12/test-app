FROM adoptopenjdk/openjdk8-openj9 AS build-stage

RUN apt-get update && \
    apt-get install -y maven unzip

COPY . /project
WORKDIR /project

RUN mvn --version
RUN mvn -X initialize process-resources verify -DskipTests  #=> to get dependencies from maven
RUN mvn clean package

RUN mkdir -p /config/dropins/spring && \
    mkdir -p /config/lib && \
    cp ./src/main/liberty/config/server.xml /config && \
    cp ./target/*.*ar /config/dropins/spring

FROM ibmcom/websphere-liberty:kernel-java8-ibmjava-ubi

RUN mkdir -p /opt/ibm/wlp/usr/shared/config/lib/global
RUN mkdir -p /opt/ibm/wlp/usr/shared/resources

COPY --chown=1001:0 --from=build-stage /config/ /config/
#COPY --chown=1001:0 --from=build-stage /config/*.properties /opt/ibm/wlp/usr/shared/resources
#COPY --chown=1001:0 --from=build-stage /sharedlibs/ /opt/ibm/wlp/usr/shared/config/lib/global

USER root
RUN configure.sh
USER 1001