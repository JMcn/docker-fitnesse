#
#

FROM FROM maven:3.2-jdk-7-onbuild
MAINTAINER Ruggero Marchei <ruggero.marchei@daemonzone.net>


RUN groupadd -r fitnesse --gid=888 \
  && useradd -d /opt/fitnesse -m -s /bin/bash -r -g fitnesse --uid=888 fitnesse


ENV GOSU_VERSION 1.7

RUN cd /usr/local/bin \
    && curl -fsSL -o gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-amd64" \
      && curl -fsSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/SHA256SUMS" | grep -E 'gosu-amd64$' | sed -e 's/gosu-.*$/gosu/' | sha256sum -c - \
        && chmod +x gosu


RUN yum install -y java-1.8.0-openjdk-headless unzip \
	  && yum clean all -q


RUN curl -fsSL -o /etc/yum.repos.d/epel-apache-maven.repo http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo \
      && sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo \
      && yum install -y apache-maven


ENV FITNESSE_RELEASE 20151230
ENV JAVA_HOME /etc/alternatives/java_sdk


RUN mkdir -p /opt/fitnesse/FitNesseRoot \
    && curl -fsSL -o /opt/fitnesse/fitnesse-standalone.jar "http://www.fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=$FITNESSE_RELEASE" \
     && chown -R fitnesse.fitnesse /opt/fitnesse

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

VOLUME /opt/fitnesse/FitNesseRoot
EXPOSE 80

WORKDIR /opt/fitnesse

RUN java -jar /opt/fitnesse/fitnesse-standalone.jar -i

#ENTRYPOINT ["/docker-entrypoint.sh"]
