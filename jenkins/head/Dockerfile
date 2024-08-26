FROM jenkins/jenkins:2.473-jdk21

LABEL version="2.473-jdk21" \
      description="Jenkins LTS-JDK21 image" \
      maintainer="jd@jdfant.com" \
      build-date="2024-08-26"

USER root

# Install Package Dependencies including SUDO Setup
# hadolint ignore=DL3008
RUN apt-get -qq update && \
    apt-get -qq install --no-install-recommends sudo wget && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers && \
    echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state


# Install Jenkins Plugins
#COPY Files/jenkins_plugins /usr/share/jenkins/ref/jenkins_plugins.txt

#RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/jenkins_plugins.txt && \
#RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins
