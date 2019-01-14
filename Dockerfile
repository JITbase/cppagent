# Use ubuntu trusty tar (14.04 LTS) as base image
FROM alpine

LABEL "project"="jitbase-cppagent"
LABEL "verstion"="1.0"

# Replace shell with bash so we can source files
# RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set the docker working directory
WORKDIR /etc/mtconnect/agent


# http://blog.zot24.com/tips-tricks-with-alpine-docker/
RUN apk add --update libxml2-dev bash build-base
RUN apk --no-cache add --update --virtual .build-dependencies \
        cmake  \
        wget \
        gcc

# Copy [from] [to]
# [dot] = all, in the case of our TO folder, it is our working directory

COPY ./agent /usr/src/cppagent/agent
COPY ./lib /usr/src/cppagent/lib

# cmake
RUN cd /usr/src/cppagent/agent && cmake .

# make
# RUN make -d --always-make --directory=agent .
RUN cd /usr/src/cppagent/agent && make ./agent

# move the made file
RUN mv /usr/src/cppagent/agent/agent /bin


# delete the dependencies no longer needed
RUN apk del .build-dependencies

# delte folder no longer needed
RUN rm -r /usr/src/cppagent

EXPOSE 5000

COPY ./samples /etc/mtconnect/samples
COPY ./simulator /etc/mtconnect/simulator
COPY ./schema /etc/mtconnect/schemas
COPY ./styles /etc/mtconnect/styles

COPY ./agent/agent.cfg /etc/mtconnect/agent/agent.cfg

# run the application
# CMD ["agent", "run", "/etc/mtconnect/agent/agent.cfg"]
ENTRYPOINT [ "/bin/agent","run" ]

# docker run -p 5000:5000 jitbase-cppagent /etc/mtconnect/agent/agent.cfg
# docker run -p 5000:5000 jitbase-cppagent /bin/agent run /etc/mtconnect/agent/agent.cfg
# docker stop $(docker ps -aq)