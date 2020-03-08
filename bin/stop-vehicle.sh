#!/bin/sh
RUN_DIR=`pwd`
cd ../vehicle
docker-compose down
docker system prune -f
cd $RUN_DIR
