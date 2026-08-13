variable "vpc_cidr" {
  type = string
  default = "10.10.0.0/16"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
}

variable "tags"{
  type = map(string)
  default = {
    platform        = "geoplatform"
    Environment = "Dev"
  }
}

variable "prefix_base" {
  type    = string
  default = "geo"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}