require 'openssl'
require 'aws-sdk-s3'
require 'aws-sdk-s3/encryption'

key = OpenSSL::PKey::RSA.new(1024)
bucket = 'client-bucket234'
object_key = 'hello.txt'

# encryption client
s3 = Aws::S3::Encryption::Client.new(
    encryption_key: key,
    region: 'us-east-1'
)

# round-trip an object, encrypted/decrypted locally
s3.put_object(bucket: bucket, key: object_key, body: 'handshake')

puts s3.get_object(bucket: bucket, key: object_key).body.read
#=> 'handshake'

# reading encrypted object without the encryption client
# results in getting the cipher text
s3_client = Aws::S3::Client.new(region: 'us-east-1')

puts s3_client.get_object(bucket: bucket, key: object_key).body.read
#=> "... cipher text ..."