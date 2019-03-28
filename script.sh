#!/bin/bash

#Start the Nginx server
sudo su -
yum update -y
systemctl start nginx                           
cd ~

# I was suppose to put this in the server AMI, but unfortunately i forgot. I dont want to go through baking again
. ~/.nvm/nvm.sh
nvm install v9.11.2 -y

# Configure Npm resource 
npm config set registry https://artifactory.sandbox8200.xyz/artifactory/api/npm/npm/
npm config set strict-ssl false
echo "_auth = YW51cGFtOkFQN0h1NFJOTVE3MW1DYmF6Qm9lOVRRa0NFVg== " >> /root/.npmrc
echo "email=anupam.mahapatra@rci.rogers.com" >> /root/.npmrc
echo "always-auth=true" >> /root/.npmrc

# Navigate to Nginx launch folder and download the latest app
cd /usr/share/nginx
npm init -y
npm install test-angular-app

#Configure Nginx to look at the app's index.html
cd /etc/nginx/conf.d
mv default.conf default.conf.old
touch default.conf
echo "server {" >> default.conf
echo "        listen 80;" >> default.conf
echo "        server_name test.anupam-mahapatra.com;" >> default.conf
echo "        root /usr/share/nginx/node_modules/test-angular-app/src;" >> default.conf
echo "        index index.html;" >> default.conf
echo "}" >> default.conf

#Restart Nginx server 
systemctl restart nginx
systemctl status nginx