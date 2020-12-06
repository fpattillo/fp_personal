#!/bin/bash
docker stop $(docker ps -a -q)
docker-compose -f /home/ubuntu/iic2173-proyecto-semestral-grupo9/docker-compose.yml down

