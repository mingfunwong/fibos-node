SNAPSHOT_FOLDER=./data/snapshots

find $SNAPSHOT_FOLDER/* -mtime +30
find $SNAPSHOT_FOLDER/* -mtime +30 -delete

fibos /fibos/start.js