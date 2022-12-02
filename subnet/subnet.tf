data "aws_availability_zones" "available" {
  state = "available"
}

# VPC Web Public Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,0)         //    var.VPC_PUBLIC_SUBNET1_CIDR_BLOCK
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "main-public-1"
  }
}



resource "aws_subnet" "main-public-2" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,1) 
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "main-public-2"
  }
}

# VPC Application Private Subnets


resource "aws_subnet" "main-private-1" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,2) 
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,3) 
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "main-private-2"
  }
}

# VPC RDS Database Private Subnets


resource "aws_subnet" "database-private-1" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,4) 
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "database-private-1"
  }
}

resource "aws_subnet" "database-private-2" {
  vpc_id                  = var.vpcid
  cidr_block              = cidrsubnet(var.vpc_cidr_block , 8 ,5) 
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[1]
  tags = {
    Name = "database-private-2"
  }
}


# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = var.vpcid
  tags = {
    Name = "main"
  }
}

# Route Table for Public
resource "aws_route_table" "main-public" {
  vpc_id = var.vpcid
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }
  tags = {
    Name = "main-public-rt"
  }
}

# Route Associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public.id
}
resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = aws_subnet.main-public-2.id
  route_table_id = aws_route_table.main-public.id
}


# NAT GW
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    "Name" = "nat"
  }
}
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.main-public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
  tags = {
    Name = "rackspace-nat-gw"
  }
}

# Route Table setup for Private through NAT
resource "aws_route_table" "main-private" {
  vpc_id = var.vpcid
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }

  tags = {
    Name = "main-private-rt"
  }
}

# Route Associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "main-private-2-a" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private.id
}


resource "aws_route_table_association" "database-private-1-a" {
  subnet_id      = aws_subnet.database-private-1.id
  route_table_id = aws_route_table.main-private.id
}
resource "aws_route_table_association" "database-private-2-a" {
  subnet_id      = aws_subnet.database-private-2.id
  route_table_id = aws_route_table.main-private.id
}
