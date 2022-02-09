FROM maven:3.8.4-jdk-11 as maven
COPY
RUN mvn package

FROM openjdk:17
COPY --from=maven target/spring-boot-demo-0.0.1-SNAPSHOT.jar /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]