data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "axyya-vpc" {
  cidr_block       = var.cidr-vpc
  instance_tenancy = "default"

  tags = {
    Name = format("%s-%s", var.vpc_name, var.env)
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(var.cidr-subnets)
  vpc_id                  = aws_vpc.axyya-vpc.id
  cidr_block              = var.cidr-subnets[count.index]
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = format("%s-%s", var.subnet_ids[count.index], var.env)
  }
}

resource "aws_internet_gateway" "axyya-igw" {
  depends_on = [aws_vpc.axyya-vpc]
  vpc_id     = aws_vpc.axyya-vpc.id

  tags = {
    Name = "${var.aws_igw_var}-${var.env}"

  }

}
resource "aws_route_table" "axyya-internet" {
  depends_on = [aws_vpc.axyya-vpc, aws_internet_gateway.axyya-igw]
  vpc_id     = aws_vpc.axyya-vpc.id
  tags = {
    Name = format("%s-%s", var.aws_rt_var[0], var.env)
  }


  route {
    cidr_block = var.aws_rt_var[1]
    gateway_id = aws_internet_gateway.axyya-igw.id

  }
}

resource "aws_route_table_association" "rt-public-subnet" {
  depends_on     = [aws_subnet.public_subnets]
  count          = length(var.cidr-subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.axyya-internet.id

}
