## Create a bucket

```sh
aws s3 mb s3://encryption-bucket234
```

## Create a file 
'''sh
aws s3 cp hello.txt s3://encryption-bucket234
'''

## Put object with encryption of KMS

'''sh
aws s3api put-object \
--bucket encryption-bucket234 \
--key hello.txt \
--body hello.txt \
--server-side-encryption '"aws:kms" \
--sse-kms-key-id ""