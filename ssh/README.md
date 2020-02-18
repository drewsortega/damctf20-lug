# SSH - known_hosts analysis

## Setup

1. Run the container
```bash
docker-compose up -d
```

2. Log in to account 'user', password 'ctf'
```bash
$ ssh user@localhost -p 5000
```

## Solution

1. Looking at all available files in home directory

```bash
$ ls -a
.  ..  .bash_logout  .bashrc  .profile  .ssh
```

2. .ssh directory is present, investigate

```bash
$ cd .ssh
$ ls -a
.  ..  id_rsa  id_rsa.pub  known_hosts
```

3. known_hosts file exists, let us see what machines we have previously connected to. 
```bash
$ cat known_hosts
tina_pc ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9NiRfkrMv08eGphrb0Nu1dXrf+8FRTPCjI+FXO5SJM1xj2bDknSMy4ncavZ/0qMWNB5YkGxPIn1DkOm9gYuOy8PGlcL1rLrG+jE1YjGqDy3HrIP3CKkyA5YrZDQut1EvETmlVOK/VW9d6lAC+6qtjk+Npm4IsmaUAlJoG2E9dU2FpCio2eAknGe4ZvCQZrTk49qyrpj5XAOa/TWBgJE/9kktl7amQoqRSoB4RGnnpoKGlpJswqIFmsZhHRgX+nPqIxcGbJ22z8EDjDUDt9z8lY4/UTIPWkjSkyRpwgMJar7baFzuV4IA3yH8Q+sLuEbMP5NWHdIAk8RyMwG7ifUsT
```

4. tina_pc is in our known hosts, so with some guessing we can get a username that will work:
```bash
$ ssh tina@tina_pc
tina@bb27e9596b27:~$
```

5. We are now connected to a different machine. Observe home directory: 
```bash
$ ls
flag
```

6. Read the flag! 
```bash
$ cat flag
[flag]
```
