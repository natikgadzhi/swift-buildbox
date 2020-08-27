ARG BASE_IMAGE
FROM $BASE_IMAGE

ENV LANGUAGE="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LC_CTYPE="en_US.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y curl

# Add the Swift for ARM repository
RUN curl -s \
  https://packagecloud.io/install/repositories/swift-arm/release/script.deb.sh | bash

# Create the user to build the code.
ARG UID=998
ARG GID=998
RUN groupadd build-user --gid=$GID -o && useradd build-user --uid=$UID --gid=$GID --create-home --shell=/bin/sh

ARG SWIFT
RUN apt-get install -y $SWIFT

# Switch to build-user and their home dir.
USER $UID
CMD echo `swift -version`