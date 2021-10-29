#!/bin/bash
set -e

docker build -t mingfunwong/fibos:1.7.1.12 .
docker-compose down
docker-compose up