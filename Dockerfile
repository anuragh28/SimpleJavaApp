# Use an OpenJDK base image
FROM openjdk:11-jre-slim

# Add a volume to store application logs
VOLUME /tmp

# Copy the application jar to the container
COPY target/your-application.jar app.jar

# Expose port 8080 (or the port your app listens on)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app.jar"]
