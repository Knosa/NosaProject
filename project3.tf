resource "aws_vpc" "VPC-TERA" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
   tags = {
    Name = "VPC-TERA"
  }
}

resource "aws_subnet" "PrivateSUB1" {
  vpc_id     = aws_vpc.VPC-TERA.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PrivateSUB1"
  }
}

resource "aws_subnet" "PrivateSUB2" {
  vpc_id     = aws_vpc.VPC-TERA.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "PrivateSUB2"
  }
}

resource "aws_subnet" "PrivateSUB3" {
  vpc_id     = aws_vpc.VPC-TERA.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "PrivateSUB3"
  }
}

resource "aws_subnet" "PublicSUB1" {
  vpc_id     = aws_vpc.VPC-TERA.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "PublicSUB1"
  }
}

resource "aws_subnet" "PublicSUB2" {
  vpc_id     = aws_vpc.VPC-TERA.id
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "PublicSUB2"
  }
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.VPC-TERA.id
  
  tags = {
    Name = "PublicRT"
  }
}
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.VPC-TERA.id

  tags = {
    Name = "PrivateRT"
  }
}

resource "aws_route_table_association" "PrivateASS" {
  subnet_id      = aws_subnet.PrivateSUB1.id 
  route_table_id = aws_route_table.PrivateRT.id
}

resource "aws_route_table_association" "PublicASS" {
         subnet_id      = aws_subnet.PublicSUB1.id
    route_table_id = aws_route_table.PublicRT.id
}


resource "aws_internet_gateway" "TARAIGW" {
  vpc_id = aws_vpc.VPC-TERA.id

  tags = {
    Name = "TARAIGW"
  }
}

# resource "aws_route_table_association" "IGWASS" {
#  gateway_id     = aws_internet_gateway.TARAIGW.id
#  route_table_id = aws_route_table.PublicRT.id
# }

resource "aws_route" "TERART" {
  gateway_id     = aws_internet_gateway.TARAIGW.id
  route_table_id            = aws_route_table.PublicRT.id
  destination_cidr_block    = "0.0.0.0/0"
  
}