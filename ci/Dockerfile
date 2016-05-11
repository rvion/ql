FROM jenkins

# add docker
USER root
RUN apt-get update -qq
RUN apt-get install curl -yq
RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get install libsystemd-journal0 libsystemd-journal-dev -yq
