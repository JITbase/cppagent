# Use ubuntu trusty tar (14.04 LTS) as base image
FROM alpine

# Replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set the docker working directory
WORKDIR /opt/mtconnect/agent

# Copy [from] [to]
# [dot] = all, in the case of our TO folder, it is our working directory

COPY ./agent /usr/src/cppagent/agent
COPY ./lib /usr/src/cppagent/lib

COPY ./agent/agent.cfg /opt/mtconnect/agent/agent.cfg

COPY ./samples /opt/mtconnect/samples
COPY ./simulator /opt/mtconnect/simulator
COPY ./schema /opt/mtconnect/schemas
COPY ./styles /opt/mtconnect/styles

# http://blog.zot24.com/tips-tricks-with-alpine-docker/
RUN apk --no-cache add --update --virtual .build-dependencies \
        libxml2-dev \
        cmake  \
        bash \
        build-base \
        gcc \
        wget

# cmake
RUN cd /usr/src/cppagent/agent && cmake .

# make
# RUN make -d --always-make --directory=agent .
RUN cd /usr/src/cppagent/agent && make ./agent

# move the made file
RUN mv /usr/src/cppagent/agent/agent /opt/mtconnect/agent/

EXPOSE 7878

# run the application
# CMD ["/opt/mtconnect/agent/agent", "run"]
