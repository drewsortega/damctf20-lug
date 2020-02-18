FROM rastasheep/ubuntu-sshd

RUN adduser --disabled-password -gecos '' user
RUN echo "user:ctf" | chpasswd

RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN mkdir /home/user/.ssh

COPY ./id_rsa /home/user/.ssh/id_rsa
COPY ./id_rsa.pub /home/user/.ssh/id_rsa.pub
COPY ./known_hosts /home/user/.ssh/known_hosts

RUN chown user /home/user/.ssh/id_rsa
RUN chmod 400 /home/user/.ssh/id_rsa

RUN chown root.root /root
RUN chmod -R -w /home/user
RUN chmod 000 /root
