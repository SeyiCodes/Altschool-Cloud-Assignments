#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt update 
sudo apt upgrade -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" 
sudo apt autoremove -y
sudo apt install -y nginx
sudo su

echo "<h1>My server Hostname or IP address is $(hostname -f)</h1>" > /var/www/html/index.nginx-debian.html

exit

sudo systemctl enable nginx 

sudo systemctl restart nginx
