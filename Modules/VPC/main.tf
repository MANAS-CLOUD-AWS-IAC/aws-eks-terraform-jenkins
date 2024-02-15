# Creating VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = default
  enable_dns_hostnames = true
  tags = {
    name = "${var.cluster_name}-vpc"
    env = var.env
    type = var.type
  }
}


# Creating Internet Gateway and attach it to VPC

resource "aws_internet_gateway" "eks_internet_gateway" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    name = "${var.cluster_name}-igw"
    env = var.env
    type = var.type
  }
}

# Using data source to get all Avalablility Zones in region

# The Availability Zones data source allows access to the list of AWS Availability Zones which can be accessed by an AWS account within the region configured in the provider.

# This is different from the aws_availability_zone (singular) data source, which provides some details about a specific availability zone.

data "aws_availability_zone" "available_zone" {
  
}

# Creating Public Subnet AZ1
resource "aws_subnet" "public_subnet_az1" {
    vpc_id = aws_vpc.eks_vpc.id
    cidr_block = var.public_subnet_az1_cidr
    availability_zone = data.aws_availability_zone.available_zone.names[0]
    map_public_ip_on_launch = true
    tags = {
        name = "Public Subnet AZ1"
        env = var.env
        type = var.type
    }
  
}

# Creating public subnet AZ2

resource "aws_subnet" "public_subnet_az2" {
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = var.public_subnet_az2_cidr
  availability_zone = data.aws_availability_zone.available_zone.names[1]
  map_public_ip_on_launch = true
  tags = {
    name = "Public Subnet AZ2"
    env = var.env
    type = var.type
  }
}

# Creating Route Table and add Public Route
# Route table is a key componeent of the Vertual Private Cloud (VPC), it is associiated with a specified VPC and controls the routing NW traffic within that VPC.

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.eks_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks_internet_gateway.id
    }
tags = {
    name = "public_route_table"
    env = var.env
    type = var.type
}
  
}

# Associating Public Subnet in AZ1 to route table

resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associating Public Subnet in AZ2 to route table
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}