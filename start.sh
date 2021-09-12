SNAPSHOT_FOLDER=./data/snapshots
URL=https://github.com/andy-backup/fibos/raw/master/snapshot.bin
wget $URL -P $SNAPSHOT_FOLDER
export SNAPSHOT_FILE=$(ls $SNAPSHOT_FOLDER/*.bin -t | head -1)
rm -rf ./data/blocks ./data/state
find $SNAPSHOT_FOLDER/* -mtime +30
find $SNAPSHOT_FOLDER/* -mtime +30 -delete

fibos /fibos/start.js