#!/bin/bash
pwd=$( aws ecr get-login-password --region us-east-2 )
sudo docker container stop $(docker container ls -aq)
sudo docker login -u AWS -p $pwd https://780722053658.dkr.ecr.us-east-2.amazonaws.com
sudo docker pull 780722053658.dkr.ecr.us-east-2.amazonaws.com/arquichat-repo

