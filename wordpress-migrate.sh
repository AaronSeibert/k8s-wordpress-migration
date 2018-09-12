#!/bin/sh
domain=$1
pod=$2
bucket=$AWS_WP_BUCKET
content_file=$domain.tgz
db_file=$domain.sql

"${AWS_WP_BUCKET:?AWS_WP_BUCKET must be set!}"

# Get files
echo "\nRetrieving $content_file from $bucket:"
aws s3 sync s3://$bucket/$content_file . --exclude "*" --include "$content_file"

echo "\nRetrieving $db_file from $bucket:"
aws s3 sync s3://$bucket/$db_file . --exclude "*" --include "$db_file"

# Push files to pod
echo "\nUploading $content_file to $pod:"
kubectl cp $content_file $pod:/wp-content.tgz

echo "\nUploading $db_file to $pod:"
kubectl cp $db_file $pod:/db.sql

# Executing pod script
echo "\nExecuting POD script..."
kubectl exec $pod -- /usr/bin/curl https://raw.githubusercontent.com/AaronSeibert/k8s-wordpress-migration/master/pod_script.sh | /bin/bash

# Clean Up
echo "\nCleaning up local files..."