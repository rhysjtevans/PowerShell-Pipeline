FROM mcr.microsoft.com/powershell:6.2.0-alpine-3.8
RUN pwsh install-module -force posh-syslog
