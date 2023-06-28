resource "aws_nat_gateway" "dev-nat-gateway" {

  depends_on = [
    aws_eip.dev-elastic-ip
  ]

  allocation_id     = aws_eip.dev-elastic-ip.id
  subnet_id         = aws_subnet.dev-public-eks-subnet2.id
  connectivity_type = "public"

  tags = {
    Name        = "dev-nat-gateway"
  }

  tags_all = {
    Name        = "dev-nat-gateway"
  }

}