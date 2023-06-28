#-------------------------------------------------------------------------------
output "web_loadbalancer_url" {
  value = aws_lb.web.dns_name
}

output "vpc_available_zone"{
    value = data.aws_availability_zones.working.zone_ids
}