# Want LTS? Append ':lts' to docker image below
FROM jenkins/jenkins

LABEL Version="2.238" \
      Description="Jenkins image with additional tools" \
      Maintainer="JD" \
      Build_Date="2020-05-27"

ENV TRY_UPGRADE_IF_NO_MARKER=true
    # Make certain you know how this works.
    # PLUGINS_FORCE_UPGRADE=true

USER 0

COPY Files/rpmwand /usr/local/bin
COPY Files/jenkins_plugins /usr/share/jenkins/ref/jenkins_plugins

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/jenkins_plugins && \
    echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    apt-get update && apt-get install -y \
      autoconf \
      automake \
      bison \
      build-essential \
      cmake \
      curl \
      gawk \
      git-core \
      less \
      libtool \
      make \
      pkg-config \
      rpm \
      texinfo \
      wget \
      --no-install-recommends && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jenkins

