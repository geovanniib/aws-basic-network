terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0 , <= 7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0, <= 4.0"
    }
  }


    # terraform migrate after it's created locally

    # backend "s3" {
    #   bucket         = "bootstrap-terraform-state-94811b09e9a09916"
    #   key            = "bootstrap/terraform.tfstate"
    #   dynamodb_table = "bootstrap-terraform-lock-94811b09e9a09916"
    #   region         = "us-east-1"  
    # }
}