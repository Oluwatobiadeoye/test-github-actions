FROM maven:3.9.9-eclipse-temurin-21 as build

COPY . /app
WORKDIR /app

RUN mvn clean package -DskipTests

# Use a lightweight JDK image to run the application
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT [ "java", "-jar", "app.jar" ]

