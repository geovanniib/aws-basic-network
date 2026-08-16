resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-vpc"
  })
}


# Create public subnets --> Only difference is a route tablle will redirect 0.0.0.0 to the internet gateway (IG is attached to the VPC)

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-public-${count.index + 1}"
  })
}

# Create private subnets --> Only difference is a route table will redirect 0.0.0.0 to a the NAT gateway
# (Regional NAT GATEWAY is the latest version of NAT gateway, which is a single gateway for all AZs in the region, attached to the VPC
#, and it will route traffic from private subnets to the internet via the NAT gateway)

# NAT GATEWAY is attachd to a public subnet (AZ), and it will route traffic from private subnets to the internet via the NAT gateway. 

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-private-${count.index + 1}"
  })
}



# Give acces to the internet

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-igw"
  })
}



resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-public-rt"
  })
}


resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id


}

################################


# NAT automode, don't need to create aws eip and associate it with the NAT gateway, terraform will do it automatically

resource "aws_nat_gateway" "private_public" {
  vpc_id            = aws_vpc.main.id
  availability_mode = "regional"

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private_public.id
  }

  tags = merge(var.tags, {
    Name = "${var.prefix_base}-private-rt"
  })
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}