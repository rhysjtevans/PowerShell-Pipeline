# PITE (PowerShell in the Enterprise)
## Overview
Building this environment has been on my to-do list since I put together and gave multiple talks on [PowerShell in the Enterprise](https://github.com/rhysjtevans/Presentations/tree/master/PowerShell%20in%20the%20Enterprise) and soon realised that there was a need for . <!-- #TODO -->
It is a colmenation of years of experience as a sysadmin and then naturally moving in to a DevOps role.


A key requirement is to be able to provision this in a cross platform way.

The aim of this repo is to provide individuals and organisations a very quick and easy way of securing and hardening their PowerShell infrastructure.

## To-do list
The to-do list may change over time, if there's anything you are keen to see - raise an issue and let me know!
### For example,
If anyone is looking
### Docker
- Docker Images
  - Concourse CI
    - + workers
  - Nexus OSS
  - ELK Stack (OpenDistro)
  - GitLab
  - Vault
### Kubernetes
- Docker images to be hosted on Docker Hub
- Statefulset
- Network Policies
- Services
- Ingress rules

### Shared
- Container configurations
  - Nexus configuration
    - Docker Repository
    - Nuget/PowerShell Repository
  - ElasticSearch
  - Kibana
  - Logstash
  - Concourse CI
    - Pipelines
    - Push logs to ElasticSearch
  - Vault
    - AppRole Auth Engine
    - PKI Backend Engine
    - Autounseal (AWS/Azure KMS)
- Client configuration
  - Beats 
    - Filebeat [Windows, Linux, MacOS]
    - Winlogbeat
