#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo echo "<h1> Webserver of terraform </h1>" > /var/www/html/index.html  
