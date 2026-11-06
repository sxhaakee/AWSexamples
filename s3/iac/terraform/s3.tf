resource "aws_s3_bucket" "my_bucket" {
  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}