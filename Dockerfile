# CentOS latest with mmremote
# Version 8.2.8
FROM centos:latest
LABEL vendor="Men & Mice" maintainer="<services@menandmice.com>" version="8.2.8-docker-beta" Description="Men & Mice Suite DNS Server Controller"

# Update image
RUN yum -y update && yum -y install wget && yum clean all
COPY named.conf /etc/named.conf
COPY localhost.db /var/named/localhost.db
RUN adduser --system --shell /bin/nologin --create-home --home-dir /var/named named
RUN wget -q http://download.menandmice.com/Linux/8.2.8/mmsuite-controllers-8.2.8.linux.x64.tgz
RUN tar xfz mmsuite-controllers-8.2.8.linux.x64.tgz
RUN mv /mmsuite-controllers*/linux/mmremoted /usr/sbin/mmremoted
RUN rm -rf /mmsuite-controllers*
VOLUME ["/var/named"]
EXPOSE 1337
WORKDIR /var/named
CMD ["/usr/sbin/mmremoted", "-unamed", "-gnamed", "-c/etc/named.conf", "-f"]
