
# Create Public Route table 
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name      = "${var.app_name}-public-route-${terraform.workspace}"
    Terraform = true
  }
}

#associate IG route to Public Route Table
resource "aws_route" "ig_public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}




#associate public route with public table
resource "aws_route_table_association" "public_route_table_association" {
  count          = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [aws_route_table.public_route_table]
}