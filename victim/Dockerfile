# Use an official Java runtime as a parent image
FROM openjdk:8u181-jdk-alpine

# Make port 25565 available to the world outside this container
EXPOSE 25565

RUN curl -fsSL -o server.jar \
    https://piston-data.mojang.com/v1/objects/5fafba3f58c40dc51b5c3ca72a98f62dfdae1db7/server.jar || \
    { echo "[-] Failed to download server.jar. Download manually from https://mcversions.net/download/1.8.8"; exit 1; }
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" >> server.properties

ENV FLAG="flag{log4sh311}"
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar", "nogui"]
