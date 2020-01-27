#!/bin/sh
cd ~/docker/vehicle
docker-compose down
docker system prune -f
cd ~
