FROM maven:3.8.5-openjdk-17 AS build

WORKDIR /app

COPY pom.xml ./
COPY .mvn .mvn
COPY mvnw ./
COPY src ./src

RUN ./mvnw package

# Use a lightweight JDK image to run the application
FROM openjdk:17-jdk-slim

ENV POSTGRES_URL=""
ENV POSTGRES_USER=""
ENV POSTGRES_PASS=""

WORKDIR /app

COPY --from=build /app/target/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar /app/app.jar --spring.profiles.active=postgres"]
