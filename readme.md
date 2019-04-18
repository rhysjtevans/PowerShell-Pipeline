# PITE (PowerShell in the Enterprise)
## Overview
Building this environment has been on my personal to-do list. <!-- #TODO -->
fault tolerent.
A key requirement is to be able to provision this in a cross platform way.

The aim of this repo is to provide individuals and organisations a very quick and easy way of securing and hardening their PowerShell infrastructure.

## To-do list
The to-do list may change over time, if there's anything you are keen to see - raise an issue and let me know!
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
- Client configuration
  - Beats 
    - Filebeat [Windows, Linux, MacOS]
    - Winlogbeat
