FROM docker.io/jenkins/jenkins:2.264
# 2.264
# 2.141 

USER root

ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/

RUN apt-get update -y && \
    apt-get install -y awscli jq gettext-base tree vim zip

RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz && \
	tar xzvf docker-18.06.1-ce.tgz && \
	cp docker/* /usr/bin/

# RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" \
#       -o /usr/local/bin/docker-compose && \
#     chmod +x /usr/local/bin/docker-compose

COPY init-scripts /usr/share/jenkins/ref/init.groovy.d

COPY new_plugins.txt /usr/share/jenkins/ref/
COPY jenkins.yaml /usr/share/jenkins/ref/

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/new_plugins.txt

# COPY source/jenkins/usr/share/jenkins/plugins.sh /usr/local/bin/plugins.sh
# COPY source/jenkins/usr/share/jenkins/plugins.txt /usr/share/jenkins/plugins.txt

# COPY source/jenkins/usr/share/jenkins/plugins.txt /usr/share/jenkins/ref/plugins.txt
# RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# RUN chmod a+x /usr/local/bin/plugins.sh
# RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

COPY source/jenkins/ /

COPY source/jenkins/var/jenkins_home/ $JENKINS_HOME/
