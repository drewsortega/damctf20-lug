FROM rastasheep/ubuntu-sshd

# add the jfobb user
RUN adduser --disabled-password -gecos '' jfobb
RUN echo "jfobb:ctf" | chpasswd
RUN passwd -n 100 jfobb
RUN passwd -d root

# set up locale just in case
RUN echo "en_US.UTF-8 UTF-8" >> /etc/local.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf

# to get man working
RUN sed -i 's:^path-exclude=/usr/share/man:#path-exclude=/usr/share/man:' \
    /etc/dpkg/dpkg.cfg.d/excludes

# install required packages and useful tools
RUN apt-get update
RUN apt-get install -y man man-db manpages-posix manpages squashfs-tools gnupg2
RUN mandb

# set bash history and home directory
RUN mkdir /home/jfobb/media
RUN echo "ls" >> /home/jfobb/.bash_history
RUN echo "ls -a" >> /home/jfobb/.bash_history
RUN echo "cp important ~/media/Documents/jfobb" >> /home/jfobb/.bash_history
RUN echo "umount ~/media" >> /home/jfobb/.bash_history
RUN echo "rm important" >> /home/jfobb/.bash_history
RUN echo "exit" >> /home/jfobb/.bash_history

# add gpg key
COPY jfobb.key /home/jfobb
RUN su - jfobb -c "gpg --import jfobb.key"
RUN rm /home/jfobb/jfobb.key

# set home dirs to read only
RUN chown root.root /root
RUN chmod 555 /home/jfobb
RUN chmod 500 /root

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

# set startup script
COPY "entrypoint.sh" "/root/entrypoint.sh"
ENTRYPOINT [ "/root/entrypoint.sh" ]
