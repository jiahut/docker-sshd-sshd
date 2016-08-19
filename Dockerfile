FROM centos:7
MAINTAINER jiahut@gmail.com
RUN yum -y update; yum clean all
RUN yum -y install openssh-server passwd; yum clean all
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN sed -ri 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN mkdir -p /root/.ssh && chown root.root /root && chmod 700 /root/.ssh
RUN echo 'root:1234qwer' | chpasswd
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]
