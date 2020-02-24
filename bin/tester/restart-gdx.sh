#!/bin/sh
RUN_DIR=`pwd`
cd ../../gdx-client
docker-compose down
docker system prune -f
sleep 1
docker-compose -f docker-compose.yml -f docker-compose-test.yml up -d
docker-compose logs -f gdx-client
cd $RUN_DIR
