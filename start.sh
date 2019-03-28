#!/bin/bash


#build a new image and run it
docker build -t myjenkins:latest .
#Here i am looking into a local folder
#username: anupam || password: password123
docker run --name myjenkins -p 6060:8080 -p 30000:50000 -v /Users/anupam.mahapatra/gitstuff/JenkinsHome2:/var/jenkins_home myjenkins:latest
