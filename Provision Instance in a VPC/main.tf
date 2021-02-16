provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

# 1. Create vpc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "prod-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}


# 2. Create Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.prod-vpc.id
}

# 3. Create Custom Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod"
  }
}

# 4. Create a Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.prod-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}

# 5. Associate subnet with Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}

# 6.Create Security Group to allow port 22,80,443
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group

resource "aws_security_group" "allow_web" {
  name = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id = aws_vpc.prod-vpc.id

  ingress {
    description = "HTTPS"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # refine if used in prod
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1" # If you select a protocol of "-1" (semantically equivalent to "all", which is not a valid value here), you must specify a "from_port" and "to_port" equal to 0. 
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_web"
  }
}

