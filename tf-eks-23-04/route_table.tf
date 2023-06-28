
########## Public Subnet Route Tables ########## 

resource "aws_route_table" "dev-route-table-pub-eks-sub1" {

  depends_on = [
    aws_vpc.dev-vpc,
    aws_internet_gateway.dev-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-internet-gateway.id
  }

  tags = {
    Name = "dev-route-table-pub-sub1"
  }

  tags_all = {
    Name = "dev-route-table-pub-sub1"
  }

  vpc_id = aws_vpc.dev-vpc.id
}

resource "aws_route_table" "dev-route-table-pub-eks-sub2" {

  depends_on = [
    aws_vpc.dev-vpc,
    aws_internet_gateway.dev-internet-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-internet-gateway.id
  }

  tags = {
    Name = "dev-route-table-pub-sub2"
  }

  tags_all = {
    Name = "dev-route-table-pub-sub2"
  }

  vpc_id = aws_vpc.dev-vpc.id
}


########## Private Subnet Route Tables ########## 

resource "aws_route_table" "dev-route-table-pri-eks-sub1" {

  depends_on = [
    aws_vpc.dev-vpc,
    aws_nat_gateway.dev-nat-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.dev-nat-gateway.id
  }

  tags = {
    Name = "dev-route-table-pri-eks-sub1"
  }

  tags_all = {
    Name = "dev-route-table-pri-eks-sub1"
  }

  vpc_id = aws_vpc.dev-vpc.id
}

resource "aws_route_table" "dev-route-table-pri-eks-sub2" {

  depends_on = [
    aws_vpc.dev-vpc,
    aws_nat_gateway.dev-nat-gateway
  ]

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.dev-nat-gateway.id
  }

  tags = {
    Name = "dev-route-table-pri-eks-sub2"
  }

  tags_all = {
    Name = "dev-route-table-pri-eks-sub2"
  }

  vpc_id = aws_vpc.dev-vpc.id
}