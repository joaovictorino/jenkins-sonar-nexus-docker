# How to create a pipeline with Jenkins, Git, SonarQube, Nexus, Docker, Terraform and Azure

## Run Jenkins, SonarQube and Nexus
Navigate to integration folder and execute

````sh
docker-compose up --build
````

## Running Jenkins
Access Jenkins on http://localhost:8080
Activate Git and Pipeline plugins during first configuration

Go to Manage Jenkins -> Global Tool Configuration
Add JDK with the following path /opt/jdk-14

Create a New Item (Freestyle) on Jenkins Dashboard:
GitHub Repository
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

Add build step with maven targets:
Goals
test

POM file
app/bank/pom.xml

Run the job

## Add project to SonarQube

Open the item before and configure other build step with maven, copy the same pom file path:
Goal
jacoco:prepare-agent install jacoco:report

Access address of SonarQube http://localhost:9000, change user password and create a project manually with maven setup, get the login id token.

Go back to Jenkins and add more one build step with maven, change login with the id token of SonarQube, copy the same pom file path:
verify sonar:sonar -DskipTests=true -Dsonar.projectKey=bank -Dsonar.host.url=http://sonarqube:9000 -Dsonar.login=f70531932e609e7df8661eccbd6d2beea534000e

Run the job and look SonarQube project dashboard

## Create Nexus Repository

Access address http://localhost:8081 and change user password.

Create repository maven2 (hosted) and allow redeploy

Install "Nexus Artifact Uploader" on Jenkins (Manage Jenkins -> Manage Plugins)

Configure new build step to generate jar file, copy the same pom file:
Jar
package -DskipTests=true

Add new build step for Nexus Artifact Uploader, following properties:
Nexus 3
URL
nexus:8081

Add credentials to Nexus user (admin)

GroupId
com.bank.account

Version
1.0

Repository
bank

Add artifacts:
ArtifactID
bank

type
jar

file 
app/bank/target/bank-1.0.jar

Upload pom.xml to Nexus:
ArtifactID
bank

type
pom

file 
app/bank/pom.xml

Run the job and look jar inside Nexus repoository

## Configure Slack Notification
Create Slack account
Add Jenkins app inside Slack

Install Slack Notification at Jenkins

Update configuration of Slack plugin at Jenkins (Manage Jenkins -> Configure System)
Set workspace, credential token and channel

Configure job with post build step (Slack Notification) check important notifications

Run the job and look Slack channel

## Build Spring Boot downloading dependency from Nexus
Create new item (freestyle) triggered by previous job, add the same GitHub repository
GitHub Repository
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

Add build step with maven goal bellow:
clean package -pl bankboot -am -DskipTests=true

POM
app/pom.xml

## Build Docker images inside Jenkins
Install Docker Pipeline plugin at Jenkins

Create repository Docker inside Nexus, type docker (hosted)
Check HTTP option, with port 9001
Enable anonymous pull
Got to Security -> Realms enable Docker Bearer

Go back to Jenkins and create new item as pipeline type, triggered by previous job for Spring Boot, add the same GitHub repository
GitHub Repository
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

Set pipeline definition from SCM Git
Script path
integration/Jenkinsfile

Run the job and look Docker repository inside Nexus

## Deploy at Azure Cloud
Install at Jenkins the plugins bellow:
- Azure Credentials
- Terraform

Set terraform path (Manage Jenkins -> Global Tool Configuration)
/usr/bin/terraform

Create a Service Principal at Azure and set inside Jenkins plugin (Manage Jenkins -> Manage Credentials -> (global) -> Add credential -> Azure Service Principal)
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"

Set the fields: SubscriptionId, ClientId, Client Secret and TenantId from Azure Account
Set the name azure_id, test the connection.

Create new item as pipeline type, triggered by previous job for Spring Boot, add the same GitHub repository
GitHub Repository
https://github.com/joaovictorino/jenkins-sonar-nexus-docker.git

Set pipeline definition from SCM Git
Script path
integration/delivery/Jenkinsfile

Create terraform repository inside Nexus following properties:
Type raw (hosted)
Name terraform

Run the job and look terraform repository inside Nexus

Access the application
````sh
curl http://aulainfraacg.eastus.azurecontainer.io:8080/account/123456
````