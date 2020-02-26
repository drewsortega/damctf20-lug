FROM rastasheep/ubuntu-sshd

# add users for challenge
RUN adduser --disabled-password -gecos '' user
RUN adduser --disabled-password -gecos '' alice
RUN echo "user:ctf" | chpasswd
RUN echo "root:asdfjaksshgwhglewhgwehoiewhgoiewhiogwehogiewhoigewh" | chpasswd
RUN passwd -n 100 user

# set locale explicitly just in case
RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

# man page file init
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
    /etc/dpkg/dpkg.cfg.d/excludes

# install useful and required packages
RUN apt-get update
RUN apt-get install -y man man-db manpages-posix manpages less
RUN mandb
RUN apt-get install -y wget libc6 libaudit1 nano

# install sudo
COPY ./sudo_1.8.16-0ubuntu1_amd64.deb /sudo_1.8.16-0.deb
RUN dpkg -i /sudo_1.8.16-0.deb
RUN rm /sudo_1.8.16-0.deb

# set sudoers file too create challenge
RUN echo "root ALL=(ALL) ALL\nalice ALL=(ALL, !root) NOPASSWD: /bin/cat, /bin/ls\nuser ALL=(alice) ALL" > /etc/sudoers
# harder version, required to use less as shell
#RUN echo "root ALL=(ALL) ALL\nalice ALL=(ALL, !root) NOPASSWD: /bin/cat, /bin/ls\nuser ALL=(alice) /bin/cat, /usr/bin/less, /bin/ls" > /etc/sudoers

# add bash history clue
RUN echo "cd /etc/\nvisudo\nls -l .\nexit" > /home/user/.bash_history

# write out flag
RUN echo 'dam{cust0m_sud0_c0nf1gs_ar3_dumb}' > /root/flag

# explicitly set ownership
RUN chown user /home/user
RUN chown alice /home/alice
RUN chown root.root /root

# make read-only - will get errors about proc since I'm lazy to disclude it.
# by removing write privledges to everything.
RUN chmod -R ugoa-w / || true
RUN chmod -R 500 /root

# make it less easy to steal solutions from other participants
RUN chmod 000 /bin/ps
RUN chmod 000 /usr/bin/top
RUN chmod 000 /bin/kill
RUN chmod 000 /usr/bin/nice
RUN chmod 000 /usr/bin/renice
RUN chmod 000 /bin/chmod
