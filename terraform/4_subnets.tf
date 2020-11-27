# create <count> number of public subnets in each availability zone
resource "aws_subnet" "public_subnets" {
  count = var.subnet_count
  cidr_block = "10.0.${var.subnet_count * (var.infrastructure_version - 1) + count.index + 1}.0/24"
  vpc_id = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  # availability_zone = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "flask-docker-tf-public-${count.index + 1}"
  }
}


# create <count> number of private subnets in each availability zone
resource "aws_subnet" "private_subnets" {
  count             = var.subnet_count
  cidr_block        = "10.0.${var.subnet_count * (var.infrastructure_version - 1) + count.index + 1 + var.subnet_count}.0/24"
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.azs.names[count.index]

  tags = {
    Name = "flask-docker-tf-private-${count.index + 1}"
  }
}
