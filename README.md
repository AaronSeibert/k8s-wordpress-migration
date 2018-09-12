# k8s-wordpress-migration
Populate helm installed WordPress from backup stored in S3

## Prerequisites
  * An existing S3 bucket
  * An AWS access/key secret pair with read access to the bucket noted above stored as a k8s secret
  * Wordpress installed from the bitnami/wordpress image

## Instructions
`kubectl exec <pod_name> -ti -- curl <insert_raw_url> | /bin/bash`
