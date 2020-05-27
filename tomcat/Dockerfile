FROM registry.home.lan/centos-base-openjdk:11.0.7+10-LTS
LABEL Tomcat_Version="9.0.35"
LABEL org.label-schema.build-date="2020-05-27"
LABEL Build_Date="2020-05-27"
LABEL Name="JD's Tomcat Image"
LABEL Maintainer="JD Fant"

ENV TC_VERSION 9.0.35
ENV TC_HOME /opt/apache-tomcat-${TC_VERSION}
ENV TC_SRC http://apache.cs.utah.edu/tomcat/tomcat-9

USER 0 

RUN dnf -y update && \
    dnf -y install apr apr-util tomcat-native \
    https://repo.home.lan/tomcat/tomcat-native-1.2.23-1.el8.x86_64.rpm && \
    dnf -y clean all && \
    rm -rf /var/cache/dnf

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -L ${TC_SRC}/v${TC_VERSION}/bin/apache-tomcat-${TC_VERSION}.tar.gz | tar -xvz -C /opt && \
    mkdir -p ${TC_HOME}/conf/Catalina/localhost && \
    chmod -R +r ${TC_HOME} && \
    find ${TC_HOME} -type d | xargs chmod +x && \
    chmod +x ${TC_HOME}/bin/* && \
    chmod -R 777 ${TC_HOME}/{work,temp,webapps,logs} && \
    rm -rf ${TC_HOME}/webapps/{ROOT,docs,examples,host-manager} && \
    ln -sf /etc/tomcat/Catalina/localhost ${TC_HOME}/conf/Catalina/localhost && \
    ln -sf ${TC_HOME} /usr/local/tomcat

COPY run.sh /run.sh

RUN chmod +x /run.sh 

USER 1001

EXPOSE 8080 8443

CMD ["/run.sh"]
