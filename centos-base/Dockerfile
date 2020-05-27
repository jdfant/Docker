FROM centos:8
LABEL CentOS_Version="8.1.1911"
LABEL org.label-schema.build-date="2020-05-27"
LABEL Build_Date="2019-05-27"
LABEL Name="CentOS 8 Base Image"
LABEL Maintainer="JD Fant"

ENV PRIVATE_CERT_URL https://repo.home.lan/RootCAs
ENV LOCAL_CERT_PATH /etc/pki/ca-trust/source/anchors

USER 0

COPY tls-ca-bundle.pem /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem

RUN chmod 644 /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem && \
    ln -sf /usr/share/zoneinfo/America/Denver /etc/localtime && \
    update-ca-trust && \
    sed -i "/distroverpkg=centos-release/a override_install_langs=en_US.utf8\ntsflags=nodocs" /etc/dnf/dnf.conf && \ 
    dnf clean all && \
    dnf -y update && \
    dnf -y install curl wget rsync procps tar zip unzip gzip bzip2 less nmap-ncat file which && \
    dnf clean all && \
    rm -rf /var/cache/dnf && \
    groupadd -g 1001 default && \
    adduser -g 1001 -u 1001 -m default 

USER 1001
CMD ["/bin/bash"]
