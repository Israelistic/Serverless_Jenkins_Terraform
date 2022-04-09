#Get all available AZ's in VPC for this region
#================================================
data "aws_availability_zones" "azs" {
  state = "available"
}

#Create public subnet # 1 in ca-central-1
#===============================
resource "aws_subnet" "shared_services_public_subnet_1" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.shared_services_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Shared Services-public-subnet_1"
  }
}

#Create public subnet # 2 in ca-central-1
#===============================
resource "aws_subnet" "shared_services_public_subnet_2" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.shared_services_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Shared Services-public-subnet_2"
  }
}

#Create private subnet # 1 in ca-central-1
#===============================
resource "aws_subnet" "shared_services_private_subnet_1" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.shared_services_vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Shared Services-private-subnet_1"
  }
}
#Create private subnet # 2 in ca-central-1
#===============================
resource "aws_subnet" "shared_services_private_subnet_2" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id     = aws_vpc.shared_services_vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "Shared Services-private-subnet_2"
  }
}
######################Subnets Associations####################
# to public rt
resource "aws_route_table_association" "shared_services_public_1_subnets_assoc" {
  subnet_id          = aws_subnet.shared_services_public_subnet_1.id
  route_table_id     = aws_route_table.shared_services_public_rt.id
}
resource "aws_route_table_association" "shared_services_public_2_subnets_assoc" {
  subnet_id          = aws_subnet.shared_services_public_subnet_2.id
  route_table_id     = aws_route_table.shared_services_public_rt.id
}
# to private rt
resource "aws_route_table_association" "shared_services_private_1_subnets_assoc" {
  subnet_id          = aws_subnet.shared_services_private_subnet_1.id
  route_table_id     = aws_route_table.shared_services_private_rt.id
}
resource "aws_route_table_association" "shared_services_private_2_subnets_assoc" {
  subnet_id          = aws_subnet.shared_services_private_subnet_2.id
  route_table_id     = aws_route_table.shared_services_private_rt.id
}