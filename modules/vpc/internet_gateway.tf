#Create IGW in ca-central-1
#========================
resource "aws_internet_gateway" "shared_igw" {
  vpc_id = aws_vpc.shared_services_vpc.id
  tags = {
    Name = "Shared Services-ITG"
  }
}