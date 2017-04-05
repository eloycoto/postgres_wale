#!/bin/bash

DB_PATH=/opt/database
PG_BIN=/usr/lib/postgresql/9.6/bin/

mkdir -p /etc/wal-e.d/env
echo "$WALE_AWS_SECRET_ACCESS_KEY" > /etc/wal-e.d/env/AWS_SECRET_ACCESS_KEY
echo "$WALE_AWS_ACCESS_KEY_ID" > /etc/wal-e.d/env/AWS_ACCESS_KEY_ID
echo "$WALE_S3_PREFIX" > /etc/wal-e.d/env/WALE_S3_PREFIX
echo "$WALE_AWS_REGION" > /etc/wal-e.d/env/AWS_REGION

mkdir $DB_PATH
chown postgres $DB_PATH

sudo -u postgres $PG_BIN/initdb -D $DB_PATH -A trust
cp /postgresql.conf $DB_PATH
cp /pg_hba.conf $DB_PATH

su - postgres -c "envdir /etc/wal-e.d/env /usr/local/bin/wal-e backup-fetch /opt/database LATEST"
sudo -u postgres rm $DB_PATH/backup_label
sudo -u postgres $PG_BIN/pg_resetxlog -f $DB_PATH
sudo -u postgres /usr/lib/postgresql/9.6/bin/pg_ctl -D /opt/database/
