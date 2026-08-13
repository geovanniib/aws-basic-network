
variable "tags" {
  type = map(string)
  default = {
    Name        = "bootstrap-repo"
    Environment = "Dev"
  }
}


variable "prefix_base" {
  type    = string
  default = "bootstrap-terraform"
}