FROM eclipse-temurin:21-jdk

WORKDIR /app

COPY target/discovery-server-0.0.1-SNAPSHOT.jar discovery-server-app.jar

EXPOSE 8081

ENTRYPOINT ["java","-jar","discovery-server-app.jar"]