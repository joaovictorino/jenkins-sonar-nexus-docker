FROM jenkins/jenkins:2.332.3

USER root

RUN apt update

RUN curl -O https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz
RUN tar xvf openjdk-14_linux-x64_bin.tar.gz
RUN mv jdk-14 /opt/
RUN apt install -y maven
RUN apt install -y lsb-release

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN chmod 0777 get-docker.sh
RUN ./get-docker.sh
RUN usermod -aG docker jenkins

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt install -y terraform