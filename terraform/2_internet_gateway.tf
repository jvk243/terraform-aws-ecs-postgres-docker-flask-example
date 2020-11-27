# create an IGW (so resources can talk to the internet)
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "flask-docker-igw"
  }
}