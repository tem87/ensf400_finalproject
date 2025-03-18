# Before building image run command: ./gradlew clean build 

FROM gradle:7.6.0-jdk11 AS builder
WORKDIR /app

# Copy Gradle-specific files first (for better caching)
COPY . .
# Download dependencies
RUN gradle dependencies --no-daemon

# Build the project
RUN gradle build --no-daemon

FROM tomcat:9.0.48-jdk11
WORKDIR /usr/local/tomcat/webapps/
COPY --from=builder /app/build/libs/ensf400_finalproject-1.0.0.war ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
