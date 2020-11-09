#!/bin/bash
docker-compose -f /home/ubuntu/fp_personal/docker-compose.production.yml down
docker stop $(docker ps -a -q)