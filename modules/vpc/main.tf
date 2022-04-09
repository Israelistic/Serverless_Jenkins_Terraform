#-----vpc/main.tf-----
#======================
provider "aws" {
  region = var.region
}

#Get all available AZ's in VPC for this region
#================================================
data "aws_availability_zones" "azs" {
  state = "available"
}

#Create VPC in ca-central-1
#========================
resource "aws_vpc" "shared_services_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "Shared Services-VPC"
  }
}


#Create IGW in ca-central-1
#========================
resource "aws_internet_gateway" "shared_igw" {
  vpc_id = aws_vpc.shared_services_vpc.id
  tags = {
    Name = "Shared Services-ITG"
  }
}

#Create public route table in ca-central-1 and grant access to the internet
#=======================================
resource "aws_route_table" "shared_services_public_rt" {
  vpc_id = aws_vpc.shared_services_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shared_igw.id
  }
  tags = {
    Name = "Shared Services-Public-RT"
  }
}
#Create private route table in ca-central-1
#=======================================
resource "aws_route_table" "shared_services_private_rt" {
  vpc_id = aws_vpc.shared_services_vpc.id

  tags = {
    Name = "Shared Services-Private-RT"
  }
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

#Create Public SG for allowing TCP/80 & TCP/22
#=======================================
resource "aws_security_group" "shared_services_public_sg" {
  name        = "shared_services_public_sg"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.shared_services_vpc.id
  #Inbound internet access
  #SSH
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #HTTP
  ingress {
    description = "allow traffic from TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  #Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "shared_services-SecurityGroup"
  }
}