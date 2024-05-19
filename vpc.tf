#* Create Virtual Private Cloud
resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.virgina_cidr

  # tags = var.tags # already declared in providers.tf
  tags = {
    "Name" = "VPC-Virginia - ${local.sufix}"
  }
}

#* Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.subnets[0]
  map_public_ip_on_launch = true

  # tags = var.tags # already declared in providers.tf
  tags = {
    "Name" = "Public-subnet - ${local.sufix}"
  }
}

#* Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.subnets[1]

  # tags = var.tags # already declared in providers.tf
  tags = {
    "Name" = "Private-subnet - ${local.sufix}"
  }

  depends_on = [
    aws_subnet.public_subnet
  ]
}

#* Provides a resource to create a VPC Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id

  tags = {
    Name = "Internet Gateway VPC Virginia - ${local.sufix}"
  }
}

#* Provides a resource to create a VPC routing table
resource "aws_route_table" "public_crt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Custom Route Table - ${local.sufix}"
  }
}

#* Provides a resource to create an association between a route table and a subnet
#* or a route table and an internet gateway or virtual private gateway
resource "aws_route_table_association" "crta_public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_crt.id
}

#* Provides a security group resource
resource "aws_security_group" "sg_public_instance" {
  name        = "Public Intance SG"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc_virginia.id

  #* Inbound rules
  dynamic "ingress" {
    for_each = var.ingress_ports_list
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.sg_ingress_cidr]
    }
  }
  # ingress {
  #   description = "SSH over Internet"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # ingress {
  #   description = "HTTP over Internet"
  #   from_port   = 80
  #   to_port     = 80
  #   protocol    = "tcp"
  #   cidr_blocks = [var.sg_ingress_cidr]
  # }

  # #* Outbound rules
  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "Public Intance SG - ${local.sufix}"
  }
}
