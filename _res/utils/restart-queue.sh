#!/bin/sh
cd ~/docker/queue
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f queue-server
cd ~
