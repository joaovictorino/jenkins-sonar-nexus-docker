# Como criar um pipeline com Jenkins, Git, SonarQube e Nexus

## Jenkins
export JAVA_HOME=/opt/jdk-14

GitHub
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

POM
app/bank/pom.xml

## Criar Projeto Sonar
JaCoCo
jacoco:prepare-agent install jacoco:report

SonarQube
verify sonar:sonar -DskipTests=true -Dsonar.projectKey=bank -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=99a2b970eec5d101b517116ede9bf47f5aa01f03

## Criar repositório Nexus
Criar repositorio maven e usuário jenkins no nexus
Instalar plugin Nexus Artifact Uploader

Jar
package -DskipTests=true

Nexus
URL
nexus:8081

Groupid
com.bank.account

Version
1.0-SNAPSHOT

Repository
bank

ArtifactID
bank

type
jar

file 
target/bank-1.0-SNAPSHOT.jar

## Configurar Slack

## Compilar Spring Boot pipeline as a code

## Implantar em nuvem