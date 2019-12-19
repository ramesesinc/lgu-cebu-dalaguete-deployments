#!/bin/sh
cd ~/docker/etracs
docker-compose down
docker system prune -f
sleep 3
docker-compose up -d
docker-compose logs -f etracs25-server
cd ~
