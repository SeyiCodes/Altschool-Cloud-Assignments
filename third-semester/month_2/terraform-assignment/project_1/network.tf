#Create VPC
resource "aws_vpc" "altschool_project_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "$(var.project_name)_vpc"
  }
}


#create data source to get all availability zones in region
data "aws_availability_zones" "availability_zones" {}



#Create Subnets
resource "aws_subnet" "first_subnet" {
  vpc_id                  = aws_vpc.altschool_project_vpc.id
  cidr_block              = var.public_subnet_cidr_az1
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  tags = {
    Name = "first_subnet"
  }
}

resource "aws_subnet" "second_subnet" {
  vpc_id                  = aws_vpc.altschool_project_vpc.id
  cidr_block              = var.public_subnet_cidr_az2
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  tags = {
    Name = "second_subnet"
  }
}

resource "aws_subnet" "third_subnet" {
  vpc_id                  = aws_vpc.altschool_project_vpc.id
  cidr_block              = var.public_subnet_cidr_az3
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.availability_zones.names[2]
  tags = {
    Name = "third_subnet"
  }
}

#Create Internet Gateway
resource "aws_internet_gateway" "altschool_project_igw" {
  vpc_id = aws_vpc.altschool_project_vpc.id
  tags = {
    Name = "$(var.project_name)_igw"
  }
}

#Create Route Table

resource "aws_route_table" "altschool_project_route-table" {
  vpc_id = aws_vpc.altschool_project_vpc.id
  route {
    cidr_block = var.anywhere_cidr
    gateway_id = aws_internet_gateway.altschool_project_igw.id
  }
  tags = {
    Name = "$(var.project_name)_route-table"
  }
}

#Create Route Table Association
resource "aws_route_table_association" "altschool_project_route-table-association-1" {
  subnet_id      = aws_subnet.first_subnet.id
  route_table_id = aws_route_table.altschool_project_route-table.id
}


resource "aws_route_table_association" "altschool_project_route-table-association-2" {
  subnet_id      = aws_subnet.second_subnet.id
  route_table_id = aws_route_table.altschool_project_route-table.id
}



resource "aws_route_table_association" "altschool_project_route-table-association-3" {
  subnet_id      = aws_subnet.third_subnet.id
  route_table_id = aws_route_table.altschool_project_route-table.id
}




#Create Network ACL
resource "aws_network_acl" "altschool_project_network-acl" {
  vpc_id = aws_vpc.altschool_project_vpc.id
  subnet_ids = [
    aws_subnet.first_subnet.id,
    aws_subnet.second_subnet.id,
    aws_subnet.third_subnet.id
  ]

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}
