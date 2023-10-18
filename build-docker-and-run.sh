#!/bin/bash
set -e

docker build -t mingfunwong/fibos:1.7.1.13 .
docker-compose down
docker-compose up