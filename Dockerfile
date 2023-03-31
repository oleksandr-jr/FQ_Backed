# AS <NAME> to name this stage as maven
FROM maven:3.9.0 AS maven

WORKDIR /usr/src/app
COPY . /usr/src/app
# Compile and package the application to an executable JAR
RUN mvn package

FROM openjdk:17

ARG JAR_FILE=spring-boot-app-1.0.0.jar

WORKDIR /opt/app

# Copy the spring-boot-api-tutorial.jar from the maven stage to the /opt/app directory of the current stage.
COPY --from=maven /usr/src/app/target/${JAR_FILE} /opt/app/
EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-boot-app-1.0.0.jar"]
