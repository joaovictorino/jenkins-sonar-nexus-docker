FROM jenkins/jenkins:lts

RUN sudo apt update
RUN sudo apt install maven
RUN sudo apt install default-jdk