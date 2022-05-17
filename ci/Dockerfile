FROM jenkins/jenkins:2.332.3

USER root

RUN apt update
RUN curl -O https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz
RUN tar xvf openjdk-14_linux-x64_bin.tar.gz
RUN mv jdk-14 /opt/
RUN apt install maven -y