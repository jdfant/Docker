FROM jenkins/jenkins:2.375.2-lts-jdk11

LABEL version="2.375.2-lts-jdk11" \
      description="Jenkins LTS image" \
      maintainer="jd@jdfant.com" \
      build-date="2023-01-19"

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
COPY Files/jenkins_plugins /usr/share/jenkins/ref/jenkins_plugins.txt

RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/jenkins_plugins.txt && \
    echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins
