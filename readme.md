# {WIP} PITE (PowerShell in the Enterprise)
## Overview
Building this environment has been on my personal to-do list. <!-- #TODO -->
fault tolerent.
A key requirement is to be able to provision this in a cross platform way.

The aim of this repo is to provide individuals and organisations a very quick and easy way of securing and hardening their PowerShell infrastructure.

### **Feedback and input Welcome!**
I always appreciate and welcome feedback both good and critiscm but most importantly feel free to submit all the Pull-Requests.

## What you get
1) Monitoring
   - provided by ELK Stack
2) Security
   - A two-tier PKI provided by Vault
   - State Configuration provided by PowerShell DSC
3) Git Repository provided by Git Lab
4) CI/CD provided by Concourse CI
5) Repositories provided by Nexus
   -  Docker Registry
   -  DSC Pull Server
6) All the client configurations you'll need to get started

Importantly, all tools are either community editions or open source.

---
# Getting Started
Over time I will be working on production ready Kubernetes Helm Charts and adding them in.   

In the meantime Docker Compose yaml it'll have to be! 😁
## Run PITE in Docker
This provides a very simple environment that you can try out the PITE environment.

Taking advantage of Docker Compose you can try PITE services on your own machine before scaling it up.    
### Install Required Tools
You will need
- [Git](https://git-scm.com/downloads)
- [Terraform](https://www.terraform.io/downloads.html)
- [PowerShell Core](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-6) - and no, PowerShell isn't just for Windows! MacOS, Linux and even ARM too!

### Set up your environment
1) Clone the Git repository
```
git clone https://github.com/rhysjtevans/powershell-pipeline.git
cd powershell-pipeline
```

2) Spin up the environment with Docker Compose

```
docker-compose up -d
```
That gets us half way there. Unfortunately there's some post set up tasks that need to happen.
Feel free to create a PR to improve/automate them.
---
## Deploy to Kubernetes
This is very much part of the second phase of this project.
I am aiming to keep the config steps below identical to both Docker & Kubernetes deployments.

## Configuring Vault, Our PKI
We'll be using terraform to configure Vault's PKI backend.
   1) First we need to collect the root token  
     Vault generates a random root token and displays it in stdout
   2) This can be done by looking at the container log for "Root Token:"  
   ```
   docker container logs powershell-pipeline_vault_1
   ``` 
   3) Grab the token from the logs and replace <TOKEN> below and run.
```
cd files/vault
terraform init 
terraform apply -auto-approve -var 'vault_token=<TOKEN>' -auto-approve

```
This configures Vault as an intermediate CA with an offline root CA certificate and produce a code signing script which we'll need later.    
Your environments will need to trust the following certs
- ./files/vault/ca-certs/root_ca.crt
- ./files/vault/ca-certs/intermediate_ca.crt

Alternatievely, you can modify files/vault/tls.___.tf to integrate into your existing PKI.

We now have a code signing certificate
- ./files/certs/codesign.crt


## Configuring Nexus, our central repository
