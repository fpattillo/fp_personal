#!/bin/bash
pwd=$( aws ecr get-login-password --region us-east-2 )
docker container stop $(docker container ls -aq)
docker login -u AWS -p $pwd https://780722053658.dkr.ecr.us-east-2.amazonaws.com/arquichat-repo
docker pull 780722053658.dkr.ecr.us-east-2.amazonaws.com/arquichat-repo

