#!/bin/sh
/bin/chmod 555 /dev/sda1
/usr/sbin/sshd -D
run /usr/local/bin/entrypoint.sh
