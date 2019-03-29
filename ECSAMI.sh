#!/bin/bash -ex
sudo su -
yum update -y
 
 
#Install wget
yum install wget -y
 
 
# Install Cloudwatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/redhat/amd64/latest/amazon-cloudwatch-agent.rpm
sudo rpm -U ./amazon-cloudwatch-agent.rpm
  
# copy the Jenkinscloudwatch json file to log to cloudwatch
 vi /opt/aws/amazon-cloudwatch-agent/bin/webserver-config.json
 sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/webserver-config.json -s
 
 
#Install AWS CLI
cd ~
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py --user
export PATH=~/.local/bin:$PATH
source ~/.bash_profile
pip --version
pip install awscli --upgrade --user
pip install awscli --upgrade --user
which aws
ln -s /root/.local/bin/aws /usr/bin
