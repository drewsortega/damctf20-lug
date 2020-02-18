FROM rastasheep/ubuntu-sshd

RUN adduser --disabled-password -gecos '' tina

RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN su - tina -c "mkdir /home/tina/.ssh"
RUN su - tina -c "ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' -C 'tina@otherpc'"
COPY ./authorized_keys /home/tina/.ssh/authorized_keys
RUN chown tina /home/tina/.ssh/authorized_keys

RUN chmod -R 500 /home/tina
RUN chmod -R -w /home/tina
RUN chmod 500 /home/tina/.ssh/authorized_keys
RUN chmod 000 /root

RUN echo "7t6SUR%P" > /home/tina/flag
