FROM rastasheep/ubuntu-sshd

RUN adduser --disabled-password -gecos '' tina
RUN passwd -d root

RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN su - tina -c "mkdir /home/tina/.ssh"
RUN su - tina -c "ssh-keygen -f ~/.ssh/id_rsa -t rsa -N '' -C 'tina@otherpc'"
COPY ./authorized_keys /home/tina/.ssh/authorized_keys
RUN chown tina /home/tina/.ssh/authorized_keys

RUN chmod 500 /home/tina/.ssh/authorized_keys
RUN chmod 000 /root

RUN echo "dam{7t6SUR%P}" > /home/tina/flag

# explicitly set ownership
RUN chown tina /home/tina
RUN chmod -R +r /home/tina
RUN chown root.root /root

# make read-only - will get errors about proc since I'm lazy to disclude it.
# by removing write privledges to everything.
RUN chmod -R ugoa-w / || true
RUN chmod -R 000 /root

# make it less easy to steal solutions from other participants
RUN chmod 000 /bin/ps
RUN chmod 000 /usr/bin/top
RUN chmod 000 /bin/kill
RUN chmod 000 /usr/bin/nice
RUN chmod 000 /usr/bin/renice
RUN chmod 000 /bin/chmod
