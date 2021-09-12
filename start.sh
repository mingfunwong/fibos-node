SNAPSHOT_FOLDER=./data/snapshots
rm -rf ./data/blocks ./data/state ./data/snapshots/*
URL=$(curl api.fibos123.com/last_snapshot)
wget $URL -P $SNAPSHOT_FOLDER
export SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)

fibos /fibos/start.js
