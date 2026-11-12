
# AWS STS Assume Role with S3

## 1. Create an IAM user with no S3 permissions

Create the IAM user:

```sh
aws iam create-user --user-name sts-machine-user
```

Create an access key:

```sh
aws iam create-access-key --user-name sts-machine-user
```

Configure the user's credentials:

```sh
aws configure --profile sts
```

Do not commit access keys or secret keys to GitHub.

## 2. Verify the IAM user

```sh
aws sts get-caller-identity --profile sts
```

This should identify:

```text
arn:aws:iam::617908174643:user/sts-machine-user
```

## 3. Create the S3 bucket and IAM role

Deploy the CloudFormation template:

```sh
./bin/deploy
```

This creates:

- An S3 bucket
- An IAM role
- An S3 permissions policy attached to the role

## 4. Allow the IAM user to assume the role

Retrieve the role ARN:

```sh
aws cloudformation describe-stacks \
    --stack-name my-sts-fun-stack \
    --query "Stacks[0].Outputs[?OutputKey=='RoleArn'].OutputValue | [0]" \
    --output text
```

Copy the ARN into policy.json.

Attach the policy:

```sh
aws iam put-user-policy \
    --user-name sts-machine-user \
    --policy-name ExamplePolicy \
    --policy-document file://policy.json
```

## 5. Configure the assumed-role profile

Edit:

```sh
nano ~/.aws/config
```

Add:

```ini
[profile assumed-sts]
role_arn = YOUR_ROLE_ARN
source_profile = sts
region = us-east-1
```

## 6. Assume the role

Verify the identity:

```sh
aws sts get-caller-identity --profile assumed-sts
```

The returned ARN should contain:

```text
assumed-role/
```

## 7. List S3 buckets using the assumed role

```sh
aws s3api list-buckets --profile assumed-sts
```

## 8. Inspect bucket permissions

Get the bucket ACL:

```sh
aws s3api get-bucket-acl \
    --bucket sts-fun-234-shakeeb-2026 \
    --profile assumed-sts
```

Get the bucket policy:

```sh
aws s3api get-bucket-policy \
    --bucket sts-fun-234-shakeeb-2026 \
    --profile assumed-sts
```

Get public access block settings:

```sh
aws s3api get-public-access-block \
    --bucket sts-fun-234-shakeeb-2026 \
    --profile assumed-sts
```

Check bucket policy public-access status:

```sh
aws s3api get-bucket-policy-status \
    --bucket sts-fun-234-shakeeb-2026 \
    --profile assumed-sts
```

Note: get-bucket-policy returns an error if no bucket policy is configured.

## 9. Clean up

When finished, remove the CloudFormation stack:

```sh
aws cloudformation delete-stack \
    --stack-name my-sts-fun-stack
```

The S3 bucket has DeletionPolicy: Retain, so it will not be automatically deleted.
