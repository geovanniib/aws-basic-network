
terraform {
  backend "s3" {
    bucket         = "bootstrap-terraform-state-94811b09e9a09916"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "bootstrap-terraform-lock-94811b09e9a09916"
  }
}