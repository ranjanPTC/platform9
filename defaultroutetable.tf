resource "aws_default_route_table" "default_routetable" {
  default_route_table_id = aws_vpc.main_vpc.default_route_table_id


  tags = {
    Name      = "${var.app_name}-default-route-table-${terraform.workspace}"
    Terraform = true
  }

}


# Route the main VPC route table traffic through the IGW
resource "aws_route" "internet_gateway_access" {
  route_table_id         = aws_vpc.main_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

