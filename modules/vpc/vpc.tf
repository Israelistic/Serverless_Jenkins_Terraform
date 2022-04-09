#Create VPC in ca-central-1
#========================
resource "aws_vpc" "shared_services_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Shared Services-VPC"
  }
}