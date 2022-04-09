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