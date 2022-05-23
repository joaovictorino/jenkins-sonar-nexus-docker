# How to create a pipeline with Jenkins, Git, SonarQube, Nexus, Docker, Terraform and Azure

## Run Jenkins, SonarQube and Nexus
Navigate to integration folder and execute

````sh
docker-compose up --build
````

## Jenkins
Configure java home folder
export JAVA_HOME=/opt/jdk-14

GitHub
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

POM
app/bank/pom.xml

## Criar Projeto Sonar
JaCoCo
jacoco:prepare-agent install jacoco:report

SonarQube
verify sonar:sonar -DskipTests=true -Dsonar.projectKey=bank -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=d184c9320e387312065a4ee0ea115ae95a64c0ad

## Criar repositório Nexus
Criar repositorio e usuário jenkins no nexus

Repositorio Nexus
Version policy
Mixed

Online

Instalar plugin Jenkins
Nexus Artifact Uploader

Configurar usuário jenkins no passo do build

Jar
package -DskipTests=true

Nexus
URL
nexus:8081

Groupid
com.bank.account

Version
1.0

Repository
bank

ArtifactID
bank

type
jar

file 
app/bank/target/bank-1.0.jar

Fazer upload do pom.xml no Nexus
ArtifactID
bank

type
pom

file 
app/bank/pom.xml

## Configurar Slack
Criar uma conta Slack
No Slack adicionar o App Jenkins

Instalar plugin Jenkins
Slack Notification

Alterar as configurações globais do Slack no jenkins
Informar dominio, token e canal

Incluir notificação no final do build

## Compilar Spring Boot baixando dependência do Nexus
Jar
clean package -pl bankboot -am -DskipTests=true

POM
app/pom.xml

## Compilar imagem Docker no Jenkins
Instalar plugin Jenkins
Docker Pipeline

Adicionar credencial global registry docker no Jenkins
admin/admin123

Criar repositorio Nexus Docker
HTTP Proxy 9001
Pull anônimo

Habilitar Docker Bearer no Nexus

Criar pipeline as code com docker apontando para arquivo jenkinsfile

## Implantar em nuvem
Instalar os seguintes plugins:
Azure Credentials
Terraform

Configurar o terraform no jenkins 
/usr/bin/terraform

Criar o Service Principal no Azure e configurar no plugin do Jenkins
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"

Criar pipeline usando jenkinsfile de delivery
