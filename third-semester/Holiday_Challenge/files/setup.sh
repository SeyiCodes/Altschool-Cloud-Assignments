#!/bin/bash

sudo apt update && sudo apt dist-upgrade -y

sudo apt install nginx -y

sudo su

echo "<h1>My server Hostname or IP address is $(hostname -f)</h1>" > /var/www/html/index.nginx-debian.html

exit

sudo systemctl enable nginx 

sudo systemctl restart nginx