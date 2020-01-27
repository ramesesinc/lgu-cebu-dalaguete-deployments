#!/bin/sh
cd ~/docker/mail
docker-compose down
docker system prune -f
cd ~
