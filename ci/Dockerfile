FROM jenkins
USER root
RUN apt-get update -qq
RUN apt-get install curl -yq
RUN curl -sSL https://get.docker.com/ | sh
# RUN apt-get install curl -yq
# RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# RUN echo 'root:pass' | chpasswd
# RUN usermod -aG docker jenkins
