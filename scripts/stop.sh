#!/bin/bash
docker-compose -f /home/ubuntu/iic2173-proyecto-semestral-grupo9/docker-compose.yml down
docker stop $(docker ps -a -q | xargs -r sudo docker stop)
docker stop $(docker ps -a -q | xargs -r sudo docker rm)
