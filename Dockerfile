# Step 1: Use an official JDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the application JAR file to the container
COPY target/helloworldapp-0.0.1-SNAPSHOT.jar app.jar

# Step 4: Expose the port that your application runs on
EXPOSE 8080

# Step 5: Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
