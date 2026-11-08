## Create a bucket name

'''md
aws s3 mb s3://checksums-example-234
'''
## Create a file that will do a checksum on
'''
echo "Hello Mars" > myfile.txt
'''
## Get a checksum of a file for md5

md5sum myfile.txt
# a949928d3e0012b0ac78b847e669b276  myfile.txt

## Upload our file aand look at its etag

aws s3 cp myfile.txt s3://checksums-example-234
aws s3api head-object --bucket checksums-example-234 --key myfile.txt

## Lets upload a file with a different kind of checksums

'''sh
sudo apt-get install rhash -y
rhash --crc32 --simple myfile.txt
'''

'''sh
aws s3api put-object \
--bucket checksums-example-234 \
--key myfile.txt \
--body myfilecrc32.txt \
--checksum algorithm="CRC32" \
--checksum-crc32="7f4cf022"
'''