FROM rastasheep/ubuntu-sshd

RUN adduser --disabled-password -gecos '' user
RUN adduser --disabled-password -gecos '' alice
RUN echo "user:ctf" | chpasswd

RUN chown root.root /home/user
RUN chown root.root /home/alice
RUN chown root.root /root

RUN chmod 555 /home/user
RUN chmod 555 /home/alice
RUN chmod 500 /root

RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
    /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get update
RUN apt-get install -y man man-db manpages-posix manpages
RUN mandb
RUN apt-get install -y wget libc6 libaudit1 nano
RUN wget https://launchpad.net/ubuntu/+archive/primary/+files/sudo_1.8.16-0ubuntu1_amd64.deb 
RUN dpkg -i ./sudo_1.8.16-0ubuntu1_amd64.deb

RUN echo "root ALL=(ALL) ALL\nalice ALL=(ALL, !root) NOPASSWD: /bin/cat, /bin/ls\nuser ALL=(alice) ALL" > /etc/sudoers

RUN echo "cd /etc/\nvisudo\nls -l .\nexit" > /home/user/.bash_history

RUN echo 'I4r5$Oo6' > /root/flag
