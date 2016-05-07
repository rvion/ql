FROM evarga/jenkins-slave
RUN apt-get update -qq
RUN apt-get install git -yq
RUN apt-get install curl -yq
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN curl -sSL https://get.docker.com/ | sh
RUN echo 'root:pass' | chpasswd
RUN usermod -aG docker jenkins
