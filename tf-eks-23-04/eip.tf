resource "aws_eip" "dev-elastic-ip" {
  network_border_group = "ap-northeast-2"
  public_ipv4_pool     = "amazon"

  tags = {
    Name        = "dev-elastic-ip"
  }

  tags_all = {
    Name        = "dev-elastic-ip"
  }

  domain = true
}