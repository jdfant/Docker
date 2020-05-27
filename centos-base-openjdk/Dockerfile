FROM registry.home.lan/centos-base:8.1.1911
LABEL OpenJDK_Version="1:11.0.7.10-1.el8_1.x86_64"
LABEL org.label-schema.build-date="2020-05-27"
LABEL Build_Date="2020-05-27"
LABEL Name="CentOS 8 Base Image with OpenJDK"
LABEL Maintainer="JD Fant"

USER 0

ENV JDK_VERSION=1:11.0.7.10-1.el8_1.x86_64
ENV JAVA_HOME=/etc/alternatives/jre
ENV JAVACMD=/etc/alternatives/java

COPY tls-ca-bundle.pem /etc/pki/ca-trust/source/anchors/

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN update-ca-trust && \
    dnf -y clean all && dnf -y update && \
    dnf -y install https://repo.home.lan/jdk/java-11-openjdk-${JDK_VERSION}.rpm && \
    dnf -y install curl wget rsync tar zip unzip gzip bzip2 less nmap-ncat file lsof && \
    dnf -y clean all && rm -rf /var/cache/dnf && \
    /usr/bin/keytool -importcert -noprompt -storepass bad_password \
        -keystore /etc/pki/java/cacerts \
        -alias tls-ca-bundle -file /etc/pki/ca-trust/source/anchors/tls-ca-bundle.pem 

USER 1001

CMD ["/bin/bash"]
