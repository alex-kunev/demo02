# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "alexk-${var.infra_env}-igw"
    Project     = var.project
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
  }
}


# NAT Gateway (NGW) - has base cost per hour to run, roughly $32/mo per NGW.
resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name        = "alexk-${var.infra_env}-eip"
    Project     = var.project
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id

  # NGW needs to be on a public subnet with an IGW
  # keys(): https://www.terraform.io/docs/configuration/functions/keys.html
  # element(): https://www.terraform.io/docs/configuration/functions/element.html

  subnet_id = aws_subnet.public[element(keys(aws_subnet.public), 0)].id

  tags = {
    Name        = "alexk-${var.infra_env}-ngw"
    Project     = var.project
    Environment = var.infra_env
    VPC         = aws_vpc.vpc.id
  }
}


# Route Tables and Routes

# Public Route Table (Subnets with IGW)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "alexk-${var.infra_env}-public-rt"
    Environment = var.infra_env
    Project     = var.project
    VPC         = aws_vpc.vpc.id
  }
}

# Private Route Tables (Subnets with NGW)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "alexk-${var.infra_env}-private-rt"
    Environment = var.infra_env
    Project     = var.project
    VPC         = aws_vpc.vpc.id
  }
}


# Public Route - any outgoing traffic from public snet goes through IGW
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route - any outgoing traffic from private snet goes through NGW
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

# Route Table Association 1 - Public Route to Public Route Table for Public Subnets
resource "aws_route_table_association" "public" {
  for_each  = aws_subnet.public
  subnet_id = aws_subnet.public[each.key].id

  route_table_id = aws_route_table.public.id
}

# Route Table Association 2 - Private Route to Private Route Table for Private Subnets
resource "aws_route_table_association" "private" {
  for_each  = aws_subnet.private
  subnet_id = aws_subnet.private[each.key].id

  route_table_id = aws_route_table.private.id
}