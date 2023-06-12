resource "aws_vpc" "custom_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "default_az1" {
  vpc_id                  = aws_vpc.custom_vpc.id
  availability_zone       = data.aws_availability_zones.working.names[0]
  cidr_block              = "10.0.1.0/24"
}

resource "aws_subnet" "default_az2" {
  vpc_id                  = aws_vpc.custom_vpc.id
  availability_zone       = data.aws_availability_zones.working.names[1]
  cidr_block              = "10.0.2.0/24"
}

resource "aws_default_route_table" "custom_route_table" {
  default_route_table_id = aws_vpc.custom_vpc.default_route_table_id
}