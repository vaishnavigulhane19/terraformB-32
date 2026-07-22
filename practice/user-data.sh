#!/bin/bash
sudo apt update 
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
echo "<h1> WEBSERVER OF TERRAFORM </h1>" > /var/www/html/index.html