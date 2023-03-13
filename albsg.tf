# Create Security groups for ALB

resource "aws_security_group" "albsg" {

  name = "${var.app_name}-alb-sg-${terraform.workspace}"

  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name      = "${var.app_name}-alb-sg-${terraform.workspace}"
    Terraform = true
  }
}
resource "aws_security_group_rule" "nlb_dc_to_alb_http" {
  type              = "ingress"
  security_group_id = aws_security_group.albsg.id
  description       = "Incoming from NLB/DC"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "nlb_dc_to_alb_https" {
  type              = "ingress"
  security_group_id = aws_security_group.albsg.id
  description       = "Incoming from NLB/DC"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "alb_to_web" {
  type                     = "ingress"
  security_group_id        = aws_security_group.albsg.id
  description              = "from request to Web Server SG"
  from_port                = var.app_port
  to_port                  = var.app_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.websg.id
}

resource "aws_security_group_rule" "alb_to_nlb_dc_http" {
  type              = "egress"
  security_group_id = aws_security_group.albsg.id
  description       = "Outgoing to NLB/DC"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}


resource "aws_security_group_rule" "alb_to_nlb_dc_https" {
  type              = "egress"
  security_group_id = aws_security_group.albsg.id
  description       = "Outgoing to NLB/DC"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
}

