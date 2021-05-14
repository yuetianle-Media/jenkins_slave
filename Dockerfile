FROM centos:centos7.8.2003
MAINTAINER "joinbright"
ADD ext_lib /root/ext_lib/
ADD https://boostorg.jfrog.io/artifactory/main/release/1.73.0/source/boost_1_73_0.tar.gz /root/ext_lib/
RUN yum -y install gcc gcc-c++ make passwd openssl openssh-server lsof ftp openssh-clients svn git rpm-build java-1.8.0-openjdk-headless java-1.8.0-openjdk epel-release && yum -y install ansible  && yum clean all \
 && sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
 && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
 && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
 && mkdir -p /var/run/sshd/ \
 && useradd -u 1000 -m -s /bin/bash jenkins \
 && echo "jenkins:jenkins" | chpasswd \
 && /usr/bin/ssh-keygen -A \
 && echo export JAVA_HOME="/`alternatives  --display java | grep best | cut -d "/" -f 2-6`" >> /etc/environment\
 && chmod a+x -R /root/ext_lib/ && /root/ext_lib/build.sh
ENV JAVA_HOME /etc/alternatives/jre
RUN echo "123456" | passwd --stdin root
WORKDIR "/root"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]