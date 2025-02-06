FROM mcr.microsoft.com/devcontainers/base:1.2.3-ubuntu-24.04

RUN apt-get update && apt-get install -y mold \
    && curl -Lo /tmp/dotslash.tar.gz https://github.com/facebook/dotslash/releases/download/v0.5.0/dotslash-ubuntu-22.04.x86_64.v0.5.0.tar.gz \
    && echo "f74716f0268cd1f7a0df67835de5534400353f3eadf7e551f6fd69217b64787f /tmp/dotslash.tar.gz" | sha256sum -c - \
    && tar -C /usr/local/bin -vxzf /tmp/dotslash.tar.gz \
    && rm /tmp/dotslash.tar.gz
