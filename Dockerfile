#
# Sshtron Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list
# Update & install packages for installing sshtron
RUN apt-get update && \
    apt-get install -y git && \
    apt-get install -y -t jessie-backports golang

#get sshtron
RUN mkdir -p /gocode
ENV GOPATH /gocode

RUN git clone https://github.com/zachlatta/sshtron.git /gocode/src/github/zachlatta/sshtron

# Set workdir
WORKDIR /gocode/src/github/zachlatta/sshtron

RUN ssh-keygen -t rsa -f id_rsa -q -N ""

EXPOSE 2022 3000

# Build
RUN go get && go build

ENTRYPOINT ./sshtron
