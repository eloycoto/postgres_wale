# Postgresql container to recover wal-e backups


## Run

docker run \
    --env "WALE_AWS_ACCESS_KEY_ID=XX" \
    --env "WALE_AWS_REGION=eu-west-1" \
    --env "WALE_AWS_SECRET_ACCESS_KEY=xxxx" \
    --env "WALE_S3_PREFIX=s3://path/" \
    eloycoto/postgres_wale
