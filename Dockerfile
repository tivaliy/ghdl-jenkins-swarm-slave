FROM java:openjdk-8-jdk
MAINTAINER Vitalii Kulanov "vitaliy@kulanov.org.ua"

ENV JENKINS_SWARM_VERSION 2.2
ENV HOME /home/jenkins-slave

# Installing the 'apt-utils' package gets rid of the 'debconf: delaying package configuration, since apt-utils is not installed' # error message when installing any other package with the apt-get package manager.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils \
 && rm -rf /var/lib/apt/lists/*

# install netstat to allow connection health check with
# netstat -tan | grep ESTABLISHED
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    net-tools \
    virtualenv \
    # install all necessary dependencies for GHDL
    gnat \
    zlib1g-dev \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# install GHDL
RUN git clone https://github.com/tgingold/ghdl.git /usr/local/src/ghdl \
 && ./usr/local/src/ghdl/configure --prefix=/usr/local \
 && make \
 && make install

RUN useradd -c "Jenkins Slave user" -d $HOME -m jenkins-slave
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION-jar-with-dependencies.jar \
 && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
