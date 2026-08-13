


resource "random_id" "bucket_id" {
  byte_length = 8
}


resource "aws_s3_bucket" "bootstrap" {
    bucket = "${var.prefix_base}-state-${random_id.bucket_id.hex}"
    tags = var.tags
}


resource "aws_s3_bucket_versioning" "bootstrap" {
  bucket = aws_s3_bucket.bootstrap.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "bootstrap" {
  name         = "${var.prefix_base}-lock-${random_id.bucket_id.hex}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}