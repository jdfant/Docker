FROM jenkins/inbound-agent:3261.v9c670a_4748a_9-2-jdk21

LABEL version="3261.v9c670a_4748a_9-2-jdk21" \
      description="JD's Jenkins JDK21 Agent image" \
      maintainer="jd@jdfant.com" \
      build_date="2024-08-26"

USER root

# Variable Definitions for Version Tagging
ENV OPENTOFU_VERSION=1.8.1 \
    TERRAFORM_VERSION=1.9.5 \
    TENV_VERSION=3.1.0 \
    APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
    DEBIAN_FRONTEND=noninteractive \
    COMPOSE_VERSION=v2.29.2

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
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/hashicorp.gpg && \
    apt-add-repository -y \
      "deb [arch=amd64] https://apt.releases.hashicorp.com \
      $(lsb_release -cs) \
      main" && \
# Install packages
    apt-get -qq update --no-install-recommends && \
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
      netcat-traditional \
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
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    aws --version && \
    rm -rf aws

# Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    docker-compose version

#Terraform (tfenv)
RUN git clone https://github.com/tfutils/tfenv.git && \
    cp tfenv/bin/* /usr/local/bin/ && cp -R tfenv/libexec /usr/local/ && cp tfenv/lib/* /usr/local/lib/ && \
    cp tfenv/share/hashicorp-keys.pgp /usr/local/share/ && /usr/local/bin/tfenv install ${TERRAFORM_VERSION} && tfenv use ${TERRAFORM_VERSION} && \
    rm -rf tfenv

#OpenTofu (tenv)
RUN LATEST_VERSION=$(curl https://api.github.com/repos/sigstore/cosign/releases/latest | jq -r .tag_name | tr -d "v") && \
    curl -O -L "https://github.com/sigstore/cosign/releases/latest/download/cosign_${LATEST_VERSION}_amd64.deb" && \
    dpkg -i cosign_${LATEST_VERSION}_amd64.deb && rm -f cosign_${LATEST_VERSION}_amd64.deb && \
    curl -O -L "https://github.com/tofuutils/tenv/releases/download/v${TENV_VERSION}/tenv_v${TENV_VERSION}_amd64.deb" && \
    dpkg -i tenv_v${TENV_VERSION}_amd64.deb && rm -f tenv_v${TENV_VERSION}_amd64.deb \
    tenv tofu install ${OPENTOFU_VERSION}

USER jenkins
