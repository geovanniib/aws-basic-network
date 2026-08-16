
terraform {
  backend "s3" {
    bucket         = "bootstrap-terraform-state-5748f43f4626c1b6"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile    = true
  }
}