#FROM ubi-init:latest
FROM registry.access.redhat.com/ubi8/ubi-init:latest
RUN yum --disableplugin=subscription-manager --nodocs -y install httpd \
  && yum --disableplugin=subscription-manager clean all \
  && echo "Hello from the httpd-parent container!" > /var/www/html/index.html \
  && systemctl enable httpd
#RUN yum -y install httpd; yum clean all; systemctl enable httpd;
#RUN echo "Successful Web Server Test" > /var/www/html/index.html

RUN chmod g=u /etc/passwd
RUN mkdir /etc/systemd/system/httpd.service.d/; echo -e '[Service]\nRestart=always' > /etc/systemd/system/httpd.service.d/httpd.conf
EXPOSE 10280
USER 1000
