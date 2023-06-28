resource "aws_internet_gateway" "dev-internet-gateway" {

  depends_on = [
    aws_vpc.dev-vpc
  ] //VPC_ID가 생성되야 internet_gateway가 생성됨

  vpc_id = aws_vpc.dev-vpc.id
}