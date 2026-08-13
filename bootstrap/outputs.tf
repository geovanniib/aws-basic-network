output "bucket_name" {
  value = aws_s3_bucket.bootstrap.bucket
}


output "dynamodb_table_name" {
  value = aws_dynamodb_table.bootstrap.name
}