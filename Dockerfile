FROM jenkins/jenkins:lts

USER root

RUN groupadd docker
RUN usermod -aG docker jenkins

RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN chown jenkins:jenkins /home/jenkins/.docker -R
RUN chmod g+rwx "$HOME/.docker" -R

USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
