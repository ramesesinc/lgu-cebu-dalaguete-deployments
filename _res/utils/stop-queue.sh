#!/bin/sh
cd ~/docker/queue
docker-compose down
docker system prune -f
cd ~
