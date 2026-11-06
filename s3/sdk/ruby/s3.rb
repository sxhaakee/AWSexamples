
# Import the AWS SDK for interacting with Amazon S3
require 'aws-sdk-s3'

# Import Pry for debugging (optional)
require 'pry'

# Import SecureRandom to generate unique identifiers
require 'securerandom'

# Import FileUtils to create directories
require 'fileutils'


# --------------------------------------------------
# 1. CONFIGURATION
# --------------------------------------------------

# Read the bucket name from an environment variable
bucket_name = ENV['BUCKET_NAME']

# Read the AWS region. Defaults to us-east-1.
region = ENV.fetch('AWS_REGION', 'us-east-1')

puts "Bucket name: #{bucket_name}"
puts "AWS Region: #{region}"

# Stop execution if no bucket name was provided
abort "Please set BUCKET_NAME" if bucket_name.nil? || bucket_name.empty?


# --------------------------------------------------
# 2. INITIALIZE S3 CLIENT
# --------------------------------------------------

# Create an S3 client using the specified AWS region
s3_client = Aws::S3::Client.new(region: region)


# --------------------------------------------------
# 3. CREATE S3 BUCKET
# --------------------------------------------------

# Create a new S3 bucket
# us-east-1 does not require a location constraint
if region == 'us-east-1'
  resp = s3_client.create_bucket(
    bucket: bucket_name
  )
else
  resp = s3_client.create_bucket(
    bucket: bucket_name,
    create_bucket_configuration: {
      location_constraint: region
    }
  )
end

puts "Bucket created: #{bucket_name}"

#binding.pry
# --------------------------------------------------
# 4. GENERATE A RANDOM NUMBER OF FILES
# --------------------------------------------------

# Generate a random integer between 1 and 6 (inclusive)
number_of_files = 1 + rand(6)

puts "Number of files: #{number_of_files}"

# Create a local tmp directory if it doesn't exist
FileUtils.mkdir_p('tmp')


# --------------------------------------------------
# 5. CREATE AND UPLOAD FILES
# --------------------------------------------------

# Repeat the operation for each file
number_of_files.times do |i|

  puts "Creating file number: #{i}"

  # Generate a filename
  file_name = "file_#{i}.txt"

  # Define the local path where the file will be stored
  output_path = "tmp/#{file_name}"

  # Create the file and write a randomly generated UUID
  File.open(output_path, 'w') do |f|
    f.write(SecureRandom.uuid)
  end

  # Open the generated file in binary read mode
  File.open(output_path, 'rb') do |f|

    # Upload the file to the S3 bucket
    s3_client.put_object(
      bucket: bucket_name,
      key: file_name,
      body: f
    )

  end

  puts "Uploaded #{file_name} to S3"

end

puts "All files uploaded successfully!"
