# Use ubuntu trusty tar (14.04 LTS) as base image
FROM alpine

# Replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set the docker working directory
WORKDIR /usr/src/cppagnet

# Copy [from] [to]
# [dot] = all, in the case of our TO folder, it is our working directory

COPY . .

# For *NIX users, you will need libxml2, cppunit, and cmake as well as build essentials.
# gcc:
# libxml2 - already installed
# cppunit - not available, used libcppunit-dev instead (stack overflow)
# cmake - ok

# alpine
#  apk add libxml2 - OK
#  apk add cppunit
#  apk add cmake
# RUN apk add --update alpine-sdk


# RUN apk add --update \
#         libxml2-dev \
#         cppunit \
#         cmake  \
#         bash \
#     && apk add --virtual build-dependencies \
#         build-base \
#         gcc \
#         wget \
#     && rm -rf /var/cache/apk/*

RUN apk add --update \
        libxml2-dev \
        cppunit \
        cmake  \
        bash \
        alpine-sdk


# compile the application
# RUN g++ -o cppagent agent.cpp

# run the application
# CMD ["/usr/src/cppagent/agent/agent"]


# Application

#RUN mkdir -p /opt/systeminsights/connect-agent
#COPY . /opt/systeminsights/connect-agent

#WORKDIR /opt/systeminsights/connect-agent

# TODO VOLUME /var/log/vimana
# TODO EXPORT ports
#EXPOSE 7000
#EXPOSE 8080


# overwrite this with 'CMD []' in a dependent Dockerfile
#CMD ["/bin/bash"]