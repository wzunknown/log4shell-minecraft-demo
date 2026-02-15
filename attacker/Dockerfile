FROM kalilinux/kali-last-release:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y install kali-linux-large xvfb

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

RUN uv tool install cua-computer-server

WORKDIR /work

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5000

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cua-computer-server", "--host", "0.0.0.0", "--port", "5000"]