FROM rastasheep/ubuntu-sshd

# add user
RUN adduser --disabled-password -gecos '' user
RUN echo "user:ctf" | chpasswd
RUN passwd -d root

# set locale 
RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

# create ssh directory
RUN mkdir /home/user/.ssh

# create ssh files
COPY ./id_rsa /home/user/.ssh/id_rsa
COPY ./id_rsa.pub /home/user/.ssh/id_rsa.pub
COPY ./known_hosts /home/user/.ssh/known_hosts

# add read access for user
RUN chown user /home/user/.ssh/id_rsa
RUN chmod 400 /home/user/.ssh/id_rsa

# explicitly set ownership
RUN chown -R user /home/user
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
