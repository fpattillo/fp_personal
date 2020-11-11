#!/bin/bash
sudo docker-compose -f /home/ubuntu/iic2173-proyecto-semestral-grupo9/docker-compose.yml down
sudo docker stop $(docker ps -a -q)