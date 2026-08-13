



run "valid_networking" {
  command = plan

  variables {
    vpc_cidr             = "10.10.0.0/16" 
    public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
    private_subnet_cidrs = ["10.10.11.0/24", "10.10.12.0/24"]
  }

  assert {
    condition     = aws_vpc.main != ""
    error_message = "VPC was not created or vpc_id output is empty."
  }

  assert {
    condition     = length(aws_subnet.public) == 2
    error_message = "Expected 2 public subnets."
  }

  assert {
    condition     = length(aws_subnet.private) == 2
    error_message = "Expected 2 private subnets."
  }
}