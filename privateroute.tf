
# Create Private Route table for App
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name      = "${var.app_name}-private-route-${terraform.workspace}"
    Terraform = true
  }
}


resource "aws_route_table_association" "private_route_table_association_app" {
  count          = length(var.private_subnet_app)
  subnet_id      = element(aws_subnet.private_subnet_app.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}

