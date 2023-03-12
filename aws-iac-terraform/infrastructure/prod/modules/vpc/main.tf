//************************************************************************************
// aws production vpc
//************************************************************************************
locals {
  vpc_name              = var.vpc_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_1_cidr  = var.public_subnet_1_cidr
  private_subnet_1_cidr = var.private_subnet_1_cidr
  us_east_1a            = var.us_east_1a
  us_east_1b            = var.us_east_1b
  production_subnet_public_1_us_east_1a   = var.production_subnet_public_1_us_east_1a
  production_subnet_private_1_us_east_1b  = var.production_subnet_private_1_us_east_1b
  public_subnet_1_route_table             = var.public_subnet_1_route_table
  private_subnet_1_route_table            = var.private_subnet_1_route_table
  production_igw                          = var.production_igw
  igw_destination_cidr_block              = var.igw_destination_cidr_block
}

resource "aws_vpc" "production_vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = local.vpc_name
  }

  lifecycle {
    prevent_destroy = true
  }
}
// create public subnet in us east 1a
resource "aws_subnet" "public_subnet_1" {
  vpc_id             = aws_vpc.production_vpc.id
  cidr_block         = local.public_subnet_1_cidr
  availability_zone  = local.us_east_1a
  tags = {
    Name = local.production_subnet_public_1_us_east_1a
  }
}

// create private subnet in us east 1b
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.production_vpc.id
  cidr_block        = local.private_subnet_1_cidr
  availability_zone = local.us_east_1b
  tags = {
    Name = local.production_subnet_private_1_us_east_1b
  }
}
//create public subnet route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.production_vpc.id
  tags = {
    Name = local.public_subnet_1_route_table
  }
}

// create private subnet route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.production_vpc.id
  tags   = {
    Name = local.private_subnet_1_route_table
  }
}
// attach public route table to production public subnet 1
resource "aws_route_table_association" "production_subnet_public_1_association" {

  route_table_id  = aws_route_table.public_route_table.id
  subnet_id       = aws_subnet.public_subnet_1.id
}
//attach private route table to production private subnet 1
resource "aws_route_table_association" "production_subnet_private_1_association" {
  route_table_id   = aws_route_table.private_route_table.id
  subnet_id        = aws_subnet.private_subnet_1.id
}

// create igw
resource "aws_internet_gateway" "production_igw" {
  vpc_id = aws_vpc.production_vpc.id
  tags   = {
    Name = local.production_igw
  }
}
// attach IGW to public route table
resource "aws_route" "public_igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  gateway_id             = aws_internet_gateway.production_igw.id
  destination_cidr_block = local.igw_destination_cidr_block
}







