# GHDL Jenkins swarm slave

[`tivalii/ghdl-jenkins-swarm-slave`](https://registry.hub.docker.com/u/tivalii/ghdl-jenkins-swarm-slave/)

A [Jenkins swarm](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) slave with [GHDL](https://github.com/tgingold/ghdl) software.


GHDL is an open-source simulator for the VHDL language.

*ghdl-jenkins-swarm-slave* allows you to compile and execute VHDL code directly in docker container. 
*ghdl-jenkins-swarm-slave* can be used as a part of CI (Continuous Integration) infrastructure ([Gerrit + Jenkins](https://github.com/tivaliy/ci-infra)) for VHDL-like projects, 
e.g. VHDL code syntax checking job, unit testing job and so on. 
For more information about GHDL see [https://github.com/tgingold/ghdl](https://github.com/tgingold/ghdl)

## Running

To run a Docker container passing [any parameters](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin#SwarmPlugin-AvailableOptions) to the slave

    docker run tivalii/ghdl-jenkins-swarm-slave -master http://jenkins:8080 -username jenkins -password jenkins -executors 1

## Building

    docker build -t tivalii/ghdl-jenkins-swarm-slave .
