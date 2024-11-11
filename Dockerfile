# Use OpenJDK as the base image
FROM openjdk:8-jdk-alpine

# Copy the built JAR file into the container
COPY target/SimpleJavaApp-1.0.jar /app.jar

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
