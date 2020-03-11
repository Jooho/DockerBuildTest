FROM registry.access.redhat.com/ubi8:latest
USER root
LABEL maintainer="John Doe"
# Update image
RUN dnf search kernel-devel --showduplicates
