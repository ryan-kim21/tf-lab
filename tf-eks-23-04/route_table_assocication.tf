########## Public Subnet Route Tables Association ########## 

resource "aws_route_table_association" "dev-route-association-pub-eks-sub1" {
  route_table_id = aws_route_table.dev-route-table-pub-eks-sub1.id
  subnet_id      = aws_subnet.dev-public-eks-subnet1.id
}

resource "aws_route_table_association" "dev-route-association-pub-eks-sub2" {
  route_table_id = aws_route_table.dev-route-table-pub-eks-sub2.id
  subnet_id      = aws_subnet.dev-public-eks-subnet2.id
}

########## Private Subnet Route Tables Association ########## 

resource "aws_route_table_association" "dev-route-association-pri-eks-sub1" {
  route_table_id = aws_route_table.dev-route-table-pri-eks-sub1.id
  subnet_id      = aws_subnet.dev-private-eks-subnet1.id
}

resource "aws_route_table_association" "dev-route-association-pri-eks-sub2" {
  route_table_id = aws_route_table.dev-route-table-pri-eks-sub2.id
  subnet_id      = aws_subnet.dev-private-eks-subnet2.id
}
