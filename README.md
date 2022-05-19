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
verify sonar:sonar -DskipTests=true -Dsonar.projectKey=bank -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=2f2d9517b58792344337945be6d795f73605c29d

## Criar repositório Nexus
Criar repositorio e usuário jenkins no nexus

Repositorio Nexus
Version policy
Mixed

Online

Instalar plugin Nexus Artifact Uploader
Configurar usuário jenkins no passo do build

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
app/bank/target/bank-1.0-SNAPSHOT.jar

## Configurar Slack
Criar uma conta Slack
No Slack adicionar o App Jenkins

No jenkins instalar o plugin do Slack
Reiniciar o jenkins
Alterar as configurações globais do Slack no jenkins
Informar dominio, token e canal

Incluir notificação no final do build

## Compilar Spring Boot baixando dependência do Nexus
Jar
mvn clean package -pl bankboot -am -DskipTests=true

POM
app/pom.xml

## Compilar imagem Docker no Jenkins
Instalar plugin Docker Pipeline no Jenkins
Criar repositorio Nexus Docker
Adicionar credencial global registry docker
Criar pipeline as code com docker apontando para arquivo jenkinsfile

## Implantar em nuvem