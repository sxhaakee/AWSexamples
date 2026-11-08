## Create a new bucket

'''sh
aws s3 mb s3://metadata-bucket234
'''

## Create a new file
'''sh
echo "Hello Mars" > hello.txt
'''

## Put an object using metadata

'''sh
aws s3api put-object --bucket="metadata-bucket234" --key="hello.txt" --body="hello.txt" --metadata Createdby=Shakeeb
'''

## Get Object Details including metadata

'''sh
aws s3api head-object --bucket="metadata-bucket234" --key="hello.txt" 
'''