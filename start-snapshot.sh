#!/bin/bash
set -e

SNAPSHOT_FOLDER=./data/snapshots

if [ "$SNAPSHOT_ENABLE" != "false" ]; then

  export SNAPSHOT_FILE=$SNAPSHOT_FOLDER/snapshot.bin
  rm -rf ./data/*

  if [ ! -d "./data" ];then
    mkdir ./data
  fi

  if [ ! -d "./data/snapshots" ];then
    mkdir ./data/snapshots
  fi

  if [ ! $SNAPSHOT_URL ]; then  
    SNAPSHOT_URL=$(curl https://api.fibos123.com/last_snapshot)
  fi
  wget $SNAPSHOT_URL -O $SNAPSHOT_FILE
fi

fibos ./start.js
