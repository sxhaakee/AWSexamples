# Create Website 1

## Create a bucket

```sh
aws s3 mb s3://cors-bucket234
```

## Change block public access

```sh
aws s3api put-public-access-block \
--bucket cors-bucket234 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket cors-bucket234 --policy file://bucket-policy.json
```

## Turn on static website hosting

```sh
aws s3api put-bucket-website --bucket cors-bucket234 --website-configuration file://website.json
```

## Upload our index.html file and include a resource that would be cross-origin

aws s3 cp index.html s3://cors-bucket234

## View the website and see if the index.html is there.

http://cors-bucket234.s3-website.ca-central-1.amazonaws.com


# Create Website 2

```sh
aws s3 mb s3://cors2-bucket234
```

## Change block public access

```sh
aws s3api put-public-access-block \
--bucket cors2-bucket234 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```sh
aws s3api put-bucket-policy --bucket cors2-bucket234 --policy file://bucket-policy2.json
```

## Turn on static website hosting

```sh
aws s3api put-bucket-website --bucket cors2-bucket234 --website-configuration file://website.json
```

## Upload our javascript file

aws s3 cp hello.js s3://cors2-bucket234

## Create API Gateway with mock response and then test the endpoint


curl -X POST -H "Content-Type: application/json" https://qva9fc3zrk.execute-api.us-east-1.amazonaws.com/prod/hello


## Set CORS on our bucket

aws s3api put-bucket-cors --bucket cors-bucket234 --cors-configuration file://cors.json