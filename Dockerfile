# Use an official Maven image with OpenJDK
FROM maven:3.9.4-eclipse-temurin-17 AS build

# Set working directory inside the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application and run tests
RUN mvn clean package

# ----------------------------
# Use a smaller image for running the app
# ----------------------------
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy the compiled JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Default command
ENTRYPOINT ["java", "-jar", "app.jar"]
