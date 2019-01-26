FROM ubuntu:18.04
MAINTAINER Dustin Chadwick <me@dchadwick.com>

# Identify the build to the container
ARG BUILD_ID=unknown
ARG GIT_BRANCH=unknown
ARG GIT_COMMIT=unknown
ARG GIT_TAG=unknown

ENV BUILD_ID $BUILD_ID
ENV GIT_BRANCH $GIT_BRANCH
ENV GIT_COMMIT $GIT_COMMIT
ENV GIT_TAG $GIT_TAG

# Install requirements
RUN apt-get update && apt-get install -y \
  #build-essential \ 
  gcc \ 
  make \
  csh && \
  apt-get clean

# Build source code
ADD . /darkcloud-src/
RUN cd /darkcloud-src/src/ && make
RUN cd /darkcloud-src/area/ && chmod +x startup

# Set runtime
WORKDIR /darkcloud-src/area/

VOLUME [ "/opt/rom" ]
EXPOSE 4000

ENTRYPOINT [ "./startup" ]