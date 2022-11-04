resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  block_public_acls   = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
       sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}