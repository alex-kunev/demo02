resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = var.infra_name
    Project = var.project
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  # Use the special function cidrsubnet to obtain a subset of ip addresses
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name    = var.public_name
    Project = var.project
    Subnet  = "${each.key}-${each.value}"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnet_numbers

  vpc_id            = aws_vpc.vpc.id
  availability_zone = each.key

  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, each.value)

  tags = {
    Name    = var.private_name
    Project = var.project
    Subnet  = "${each.key}-${each.value}"
  }
}