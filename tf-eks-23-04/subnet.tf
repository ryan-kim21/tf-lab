resource "aws_subnet" "dev-public-eks-subnet1" {
    depends_on = [
      aws_vpc.dev-vpc
    ]

    assign_ipv6_address_on_creation                = "false"
    cidr_block                                     = "10.20.1.0/24"
    enable_dns64                                   = "false"
    enable_resource_name_dns_a_record_on_launch    = "false"
    enable_resource_name_dns_aaaa_record_on_launch = "false"
    ipv6_native                                    = "false"
    map_public_ip_on_launch                        = "true"
    private_dns_hostname_type_on_launch            = "ip-name"

    tags = {
        Name = "dev-public-eks-subnet1"
        "kubernetes.io/cluster/dev-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
    }
    
    tags_all = {
    Name                                     = "dev-public-eks-subnet1"
    "kubernetes.io/cluster/dev-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
    }

    vpc_id = aws_vpc.dev-vpc.id
    availability_zone = "ap-northeast-2a"

}

resource "aws_subnet" "dev-public-eks-subnet2" {
    depends_on = [
      aws_vpc.dev-vpc
    ]

    assign_ipv6_address_on_creation                = "false"
    cidr_block                                     = "10.20.2.0/24"
    enable_dns64                                   = "false"
    enable_resource_name_dns_a_record_on_launch    = "false"
    enable_resource_name_dns_aaaa_record_on_launch = "false"
    ipv6_native                                    = "false"
    map_public_ip_on_launch                        = "true"
    private_dns_hostname_type_on_launch            = "ip-name"

    tags = {
        Name = "dev-public-eks-subnet2"
        "kubernetes.io/cluster/dev-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
    }
    
    tags_all = {
    Name                                     = "dev-public-eks-subnet2"
    "kubernetes.io/cluster/dev-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
    }
    
    vpc_id = aws_vpc.dev-vpc.id
    availability_zone = "ap-northeast-2c"

}

############ Private Subnets ############

resource "aws_subnet" "dev-private-eks-subnet1" {
    depends_on = [
      aws_vpc.dev-vpc
    ]

    assign_ipv6_address_on_creation                = "false"
    cidr_block                                     = "10.20.3.0/24"
    enable_dns64                                   = "false"
    enable_resource_name_dns_a_record_on_launch    = "false"
    enable_resource_name_dns_aaaa_record_on_launch = "false"
    ipv6_native                                    = "false"
    map_public_ip_on_launch                        = "true"
    private_dns_hostname_type_on_launch            = "ip-name"

    tags = {
        Name = "dev-private-eks-subnet1"
        "kubernetes.io/cluster/dev-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
    }
    
    tags_all = {
    Name                                     = "dev-private-eks-subnet1"
    "kubernetes.io/cluster/dev-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
    }

    vpc_id = aws_vpc.dev-vpc.id
    availability_zone = "ap-northeast-2a"

}

resource "aws_subnet" "dev-private-eks-subnet2" {
    depends_on = [
      aws_vpc.dev-vpc
    ]

    assign_ipv6_address_on_creation                = "false"
    cidr_block                                     = "10.20.4.0/24"
    enable_dns64                                   = "false"
    enable_resource_name_dns_a_record_on_launch    = "false"
    enable_resource_name_dns_aaaa_record_on_launch = "false"
    ipv6_native                                    = "false"
    map_public_ip_on_launch                        = "true"
    private_dns_hostname_type_on_launch            = "ip-name"

    tags = {
        Name = "dev-private-eks-subnet2"
        "kubernetes.io/cluster/dev-eks-cluster" = "shared"
        "kubernetes.io/role/elb"                 = 1
    }
    
    tags_all = {
    Name                                     = "dev-private-eks-subnet2"
    "kubernetes.io/cluster/dev-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                 = 1
    }

    vpc_id = aws_vpc.dev-vpc.id
    availability_zone = "ap-northeast-2c"

}




