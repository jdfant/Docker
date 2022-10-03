FROM jenkins/inbound-agent:4.13.3-1-jdk11

LABEL version="4.13.3-1-jdk11" \
      description="Jenkins JDK11 Agent image" \
      maintainer="jd@jdfant.com" \
      build-date="2022-09-25"

USER root

# Variable Definitions for Version Tagging
ENV TERRAFORM_VERSION=1.3.1 \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 \
    DEBIAN_FRONTEND=noninteractive \
    COMPOSE_VERSION=v2.11.1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Configure APT Repositories
# hadolint ignore=DL3008
RUN apt-get -qq update --no-install-recommends && \
    apt-get -qq install --no-install-recommends --no-install-suggests \
      apt-utils \
      curl \
      dialog \
      gnupg2 \
      software-properties-common && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository \
      "deb [arch=amd64] https://apt.releases.hashicorp.com \
      $(lsb_release -cs) \
      main" && \
# Install packages
    apt-get -qq update --no-install-recommends && \
    apt-get -qq install --no-install-recommends --no-install-suggests apt-utils dialog software-properties-common && \
    apt-get -qq install --no-install-recommends --no-install-suggests \
      ansible \
      apt-transport-https \
      autoconf \
      automake \
      bash \
      bison \
      build-essential \
      bzip2 \
      ca-certificates \
      cmake \
      curl \
      file \
      gawk \
      gcc \
      g++ \
      git \
      git-core \
      git-lfs \
      gnupg2 \
      inetutils-ping \
      jq \
      less \
      libffi-dev \
      libgdbm-dev \
      libncurses5-dev \
      libnss3-dev \
      libreadline-dev \
      libssl-dev \
      libtool \
      lsb-release \
      make \
      nasm \
      netcat \
      packer \
      pkg-config \
      postgresql-client \
      procps \ 
      python3-pip \
      python3-yaml \
      python3-requests \
      python3-setuptools \
      python3-venv \
      python3-virtualenv \
      python3-wheel \
      rpm \
      sudo \
      systemd-sysv \
      texinfo \
      unzip \
      vim \
      wget \
      yasm \
      zip \
      zlib1g-dev && \
    apt-get -qq autoremove && \
    apt-get -qq clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'Defaults      secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/java/openjdk/bin" ' > /etc/sudoers.d/jenkins && \
    echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers.d/jenkins

# AWS CLI
# hadolint ignore=DL3013
RUN pip3 install --no-cache-dir awscliv2

# Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

#Terraform (tfenv)
RUN git clone https://github.com/tfutils/tfenv.git && \
    cp tfenv/bin/* /usr/local/bin/ && cp -R tfenv/libexec /usr/local/ && cp tfenv/lib/* /usr/local/lib/ && \
    cp tfenv/share/hashicorp-keys.pgp /usr/local/share/ && /usr/local/bin/tfenv install ${TERRAFORM_VERSION} && tfenv use ${TERRAFORM_VERSION} && \
    rm -rf tfenv

USER jenkins
