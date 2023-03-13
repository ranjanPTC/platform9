#create  Public subnets  for alb and nat instances
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet)
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 3, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index % var.az_count]
  vpc_id            = aws_vpc.main_vpc.id
  tags = {
    Name      = "${var.app_name}-${var.public_subnet[count.index]}-${terraform.workspace}"
    Terraform = true
  }

  depends_on = [aws_vpc.main_vpc]
}


#create  private  subnets 
resource "aws_subnet" "private_subnet_web" {
  count             = length(var.private_subnet_web)
  cidr_block        = cidrsubnet(aws_vpc.main_vpc.cidr_block, 3, count.index + 2)
  availability_zone = data.aws_availability_zones.available.names[count.index % var.az_count]
  vpc_id            = aws_vpc.main_vpc.id
  tags = {
    Name      = "${var.app_name}-${var.private_subnet_web[count.index]}-${terraform.workspace}"
    Terraform = true
  }

  depends_on = [aws_vpc.main_vpc]

}


