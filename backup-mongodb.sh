#!/bin/bash

set -e

SCRIPT_NAME=backup-mongodb
ARCHIVE_NAME=mongodump_$(date +%Y%m%d_%H%M%S).gz

echo "[$SCRIPT_NAME] Dumping all MongoDB databases to compressed archive..."
mongodump --uri "$MONGODB_URI" -v --archive="$ARCHIVE_NAME" --db=$MONGODB_DB_NAME --gzip

echo "[$SCRIPT_NAME] Uploading compressed archive to S3 bucket..."
aws s3 cp "$ARCHIVE_NAME" "$BUCKET_URI/$SUBFOLDER/$ARCHIVE_NAME" --endpoint-url "$AWS_ENDPOINT_URL"

echo "[$SCRIPT_NAME] Cleaning up compressed archive..."
rm "$ARCHIVE_NAME"

echo "[$SCRIPT_NAME] Backup complete!"
