# Use an official Java runtime as a parent image
FROM openjdk:8u181-jdk-alpine

# Make port 25565 available to the world outside this container
EXPOSE 25565

ADD server.jar server.jar
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" >> server.properties

ENV FLAG="flag{log4sh311}"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
