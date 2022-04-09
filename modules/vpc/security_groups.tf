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