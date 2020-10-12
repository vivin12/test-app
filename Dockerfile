FROM maven:3.6.3-jdk-8

# package our application code
#RUN mvn clean package
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

#Stage and thin the application
FROM openliberty/open-liberty:kernel-java8-openj9-ubi as staging

COPY --chown=1001:0 target/demo-0.0.1-SNAPSHOT.jar \
                    /staging/fat-demo-0.0.1-SNAPSHOT.jar

RUN springBootUtility thin \
 --sourceAppPath=/staging/fat-demo-0.0.1-SNAPSHOT.jar \
 --targetThinAppPath=/staging/thin-demo-0.0.1-SNAPSHOT.jar \
 --targetLibCachePath=/staging/lib.index.cache

#Build the image
FROM openliberty/open-liberty:kernel-java8-openj9-ubi

RUN cp /opt/ol/wlp/templates/servers/springBoot2/server.xml /config/server.xml

COPY --chown=1001:0 --from=staging /staging/lib.index.cache /lib.index.cache
COPY --chown=1001:0 --from=staging /staging/thin-demo-0.0.1-SNAPSHOT.jar \
                    /config/dropins/spring/thin-demo-0.0.1-SNAPSHOT.jar

RUN configure.sh