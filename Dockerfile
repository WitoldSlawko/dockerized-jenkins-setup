FROM docker.io/jenkins/jenkins:2.265

USER root

ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/

RUN apt-get update -y
RUN apt-get upgrade -y 
RUN apt-get install -y awscli jq gettext-base tree vim zip

RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz && \
	tar xzvf docker-18.06.1-ce.tgz && \
	cp docker/* /usr/bin/

RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

COPY ./init-scripts /usr/share/jenkins/ref/init.groovy.d

ADD ./configs/plugins.txt /usr/share/jenkins/ref/
ADD ./configs/jenkins.yaml /usr/share/jenkins/ref/
ADD ./configs/locale.xml /usr/share/jenkins/ref/
ADD ./configs/org.jenkinsci.plugins.terraform.TerraformBuildWrapper.xml /usr/share/jenkins/ref/

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#COPY source/jenkins/var/jenkins_home/ $JENKINS_HOME/

