#                                                                                                                                                                                                                  
# Licensed under Apache License v2. See LICENSE for more information.
#

# 
# dds-daemon (OpenSplice) docker image 
#
# Howto:
# Download the latest OpenSplice community edtion from www.prismtech.com
# Move OpenSplice tar ball to resources/OpenSpliceDDS-src.tar.gz
#   NOTE: registration and manual license agreement needed.
# Build docker image -> docker build -t dds-daemon .
#
# TODO

FROM ubuntu:14.04
MAINTAINER Pepijn Noltes <pepijnnoltes@gmail.com> 

# Generic update & tooling
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -yq && apt-get install -yq --no-install-recommends \
  build-essential \
  curl \
  gdb  \
  git \
  gawk \ 
  postfix \
  && apt-get clean
#NOTE postfix needed for cleanup

#run cd /tmp && git config --global http.sslverify false && git clone https://github.com/coreos/etcd && cd etcd && ./build
RUN cd /tmp && curl -k -L https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz | tar xzf - && \
	cp etcd-v0.4.6-linux-amd64/etcd /bin/ && cp etcd-v0.4.6-linux-amd64/etcdctl /bin/ 

# Node agent resources
ADD resources /tmp/resources

RUN cd /tmp && tar xzf /tmp/resources/OpenSpliceDDS-src.tar.gz 
RUN cd /tmp/OpenSplice* && ./configure x86_64.linux-release && make && make install
