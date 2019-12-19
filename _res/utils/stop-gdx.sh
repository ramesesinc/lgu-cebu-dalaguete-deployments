#!/bin/sh
cd ~/docker/gdx-client
docker-compose down
docker system prune -f
cd ~
