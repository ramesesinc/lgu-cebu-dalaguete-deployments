#!/bin/sh
cd ~/docker/mail
docker-compose down
docker system prune -f
sleep 1
docker-compose up -d
docker-compose logs -f gdx-mail-server
cd ~
