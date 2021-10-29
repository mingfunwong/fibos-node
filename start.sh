#!/bin/bash
set -e

SNAPSHOT_FOLDER=./data/snapshots
rm -rf ./data/*

if [ "$SNAPSHOT_ENABLE" = "true" ]; then

  if [ ! -d "./data" ];then
    mkdir ./data
  fi

  if [ ! -d "./data/snapshots" ];then
    mkdir ./data/snapshots
  fi

  if [ ! $SNAPSHOT_URL ]; then  
    SNAPSHOT_URL=$(curl api.fibos123.com/last_snapshot)
  fi
  wget $SNAPSHOT_URL -P $SNAPSHOT_FOLDER
  export SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
fi

fibos /fibos/start.js
