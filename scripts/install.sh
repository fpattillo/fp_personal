#!/bin/bash
pwd=$( aws ecr get-login-password )
docker container stop $(docker container ls -aq)
docker login -u AWS -p $pwd https://780722053658.dkr.ecr.us-east-2.amazonaws.com
docker pull 780722053658.dkr.ecr.us-east-2.amazonaws.com/Arquichat

