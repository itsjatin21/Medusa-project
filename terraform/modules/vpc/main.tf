resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" 
    enable_dns_hostnames = true

    tags = {
        Name = "Medusa VPC"
    }
}

resource "aws_subnet" "public" {
    count       = 2
    vpc_id      = aws_vpc.main.id
    cidr_block = cidrsubnet("10.0.0.0/16", 8, count.index)
    availability_zone = ["us-east-1a", "us-east-1b"][count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "Medusa Public Subnet ${count.index + 1}"
    }

  }
resource "aws_subnet" "private" {
    count       = 2
    vpc_id      = aws_vpc.main.id
    cidr_block  = cidrsubnet("10.0.0.0/16", 8, count.index + 2)
    availability_zone = ["us-east-1a", "us-east-1b"][count.index]

    tags = {
        Name = "Medusa Private Subnet ${count.index + 1}"
    }
  
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
    tags = {
        Name = "Medusa igw"
    }
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "Medusa Public RT"
  }
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
