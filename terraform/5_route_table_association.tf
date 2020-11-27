# Associate the public subnets with the public route table
resource "aws_route_table_association" "public-rt-association" {
  count = var.subnet_count
  route_table_id = aws_route_table.rt_public.id
  subnet_id = aws_subnet.public_subnets.*.id[count.index]
}

# Associate the private subnets with the public route table
resource "aws_route_table_association" "private-rt-association" {
  count = var.subnet_count
  route_table_id = aws_route_table.rt_public.id
  subnet_id = aws_subnet.private_subnets.*.id[count.index]
}