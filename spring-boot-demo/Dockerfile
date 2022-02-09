FROM maven:3.8.4-openjdk-17-slim as maven
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml package

FROM openjdk:17
COPY --from=maven /usr/src/app/target/spring-boot-demo-0.0.1-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]