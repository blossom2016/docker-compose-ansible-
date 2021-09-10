FROM ubuntu:latest
RUN apt-get update && apt-get upgrade
RUN groupadd -g 71000 ansible
RUN useradd -rm -d /home/ansible -s /bin/bash -u 71000 -g ansible -G root ansible
RUN echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN apt install openssh-server -y
COPY /ssh/id_rsa.pub /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible/.ssh
RUN chmod 600 /home/ansible/.ssh/authorized_keys
RUN cat > /etc/motd.msg
RUN chmod 777 /etc/motd.msg
RUN chmod -R 0644 /etc/update-motd.d/
RUN sed -i 's+#Banner.*+Banner /etc/motd.msg+g' /etc/ssh/sshd_config
RUN sed -i 's/#PrintMotd.*/PrintMotd yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN service ssh start
CMD ["/usr/sbin/sshd","-D"]

