provider "aws" {
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available"{}

terraform {
  backend "s3"{
    bucket = "ryan5100"
    key = "dev/network/terrafrom.tfstate"
    region = "ap-northeast-2"
  }
}

resource "aws_vpc" "main"{
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
        Owner = "Ryan Kim"
    }
}


resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.env}-igw"
        Owner = "Ryan Kim"
    }
  
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name  = "${var.env}-public-${count.index + 1}"
    Owner = "Ryan Kim"
  }
}

resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = {
    Name  = "${var.env}-route-public-subnets"
    Owner = "Ryan Kim"
  }
}

resource "aws_route_table_association" "public_routes" {
  count          = length(aws_subnet.public_subnets[*].id)
  route_table_id = aws_route_table.public_subnets.id
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
