#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt update -y
sudo NEEDRESTART_MODE=a apt dist-upgrade
sudo apt autoremove 
sudo NEEDRESTART_MODE=a sudo apt-get install -y nginx 
sudo su

echo "<h1>My server Hostname or IP address is $(hostname -f)</h1>" > /var/www/html/index.nginx-debian.html

exit

sudo systemctl enable nginx 

sudo systemctl restart nginx
