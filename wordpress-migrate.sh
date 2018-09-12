#!/bin/sh
domain=$1
pod=$2
bucket=$3
content_file=$domain.tgz
db_file=$domain.sql

# Get files
echo "\nRetrieving $content_file from $bucket:"
aws s3 cp s3://$bucket/$content_file $content_file

echo "\nRetrieving $db_file from $bucket:"
aws s3 cp s3://$bucket/$db_file $db_file

# Push files to pod
echo "\nUploading $content_file to $pod:"
kubectl cp $content_file $pod:/content.tgz

echo "\nUploading $db_file to $pod:"
kubectl cp $db_file $pod:/db.sql

# Executing pod script
echo "\nExecuting POD script..."
kubectl cp pod_script.sh $pod:/pod_script.sh
kubectl exec $pod -ti -- /pod_script.sh

# Clean Up
echo "\nCleaning up local files..."
rm $content_file $db_file pod_script.sh
