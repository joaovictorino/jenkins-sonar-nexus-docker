FROM jenkins/jenkins:2.332.3

USER root

RUN apt update

RUN curl -O https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz
RUN tar xvf openjdk-14_linux-x64_bin.tar.gz
RUN mv jdk-14 /opt/
RUN apt install -y maven

RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN chmod 0777 get-docker.sh
RUN ./get-docker.sh
RUN usermod -aG docker jenkins

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null
RUN AZ_REPO=$(lsb_release -cs) 
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | sudo tee /etc/apt/sources.list.d/azure-cli.list
RUN apt install -y azure-cli
