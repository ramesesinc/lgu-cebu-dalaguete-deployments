#!/bin/sh
cd ~/docker/etracs
docker-compose down
docker system prune -f
cd ~
