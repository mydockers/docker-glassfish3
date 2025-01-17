FROM openjdk:7u221-jre

MAINTAINER FANTINEL L <leandrofantinel@gmail.com>

RUN apt update && apt -y upgrade\
    apt install -y wget unzip pwgen expect && \
    wget http://download.oracle.com/glassfish/3.1.2.2/release/glassfish-3.1.2.2.zip && \
    unzip glassfish-3.1.2.2.zip -d /opt && \
    rm glassfish-3.1.2.2.zip && \
    apt autoremove && apt autoclean && apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH /opt/glassfish3/bin:$PATH

ADD run.sh /run.sh
ADD change_admin_password.sh /change_admin_password.sh
ADD change_admin_password_func.sh /change_admin_password_func.sh
ADD enable_secure_admin.sh /enable_secure_admin.sh
RUN chmod +x /*.sh

# 4848 (administration), 8080 (HTTP listener), 8181 (HTTPS listener)
EXPOSE 4848 8080 8181

CMD ["/run.sh"]
