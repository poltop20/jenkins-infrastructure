resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
   block_public_acls   = true

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}