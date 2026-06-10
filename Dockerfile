# Étape 1 : Build avec Maven
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Étape 2 : Image finale légère
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
