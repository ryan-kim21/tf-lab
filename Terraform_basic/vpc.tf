# Create AWS VPC

resource "aws_vpc" "levelup_vpc"{
    cider_block = "10.0.0.0/16"
    instance_tenancy = "default"

    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"

    tags ={
        Name = "levelup_vpc"
    }
}


# Create public subnet 
resource "aws_subnet" "levelupvpc-public-1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "levelupvpc-public-1"
  }
}

resource "aws_subnet" "levelupvpc-public-2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "levelupvpc-public-2"
  }
}

resource "aws_subnet" "levelupvpc-public-2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "levelupvpc-public-3"
  }
}

# Create pravate subnet 
resource "aws_subnet" "levelupvpc-private-1" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "levelupvpc-private-1"
  }
}

resource "aws_subnet" "levelupvpc-private-2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "levelupvpc-private-2"
  }
}

resource "aws_subnet" "levelupvpc-private-2" {
  vpc_id     = aws_vpc.levelup_vpc.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "levelupvpc-private-3"
  }
}



# Custom insternet Gateway
resource "aws_internet_gateway" "levelup-gw" {
  vpc_id = aws_vpc.levelup_vpc.id

  tags = {
    Name = "levelup-gw"
  }
}

# # Custom insternet Gateway attachment
# resource "aws_internet_gateway_attachment" "levelup-gw-attachment" {
#   internet_gateway_id = aws_internet_gateway.levelup-gw.id
#   vpc_id              = aws_vpc.levelup_vpc.id
# }

# resource "aws_vpc" "levelup_vpc" {
#   cidr_block = "10.1.0.0/16"
# }

# resource "aws_internet_gateway" "example" {}

# Routing Table for the Custom VPC
resource "aws_default_route_table" "levelup_public" {
  vpc_id = aws_vpc.levelup_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup-gw.id
  }


  tags = {
    Name = "levelupvpc-public-1"
  }
}


resource "aws_route_table_association" "levelup-public-1-a" {
  subnet_id      = aws_subnet.levelupvpc-public-1.id
  route_table_id = aws_default_route_table.levelup_public.id
}

resource "aws_route_table_association" "levelup-public-2-c" {
  subnet_id      = aws_subnet.levelupvpc-public-1.id
  route_table_id = aws_default_route_table.levelup_public.id
}


resource "aws_route_table_association" "levelup-public-3-a" {
  subnet_id      = aws_subnet.levelupvpc-public-1.id
  route_table_id = aws_default_route_table.levelup_public.id
}













