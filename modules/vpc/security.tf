resource "aws_security_group" "axyya-security-group1" {
  vpc_id = aws_vpc.axyya-vpc.id
  name   = var.aws_sg1_in_var[0]
  ingress {
    description = var.aws_sg1_in_var[1]
    from_port   = 0
    to_port     = 0
    protocol    = var.aws_sg1_in_var[2]
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = var.aws_sg_out_var[0]
    from_port   = 0
    to_port     = 0
    protocol    = var.aws_sg_out_var[1]
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = format("%s-%s", var.aws_sg1_in_var[0], var.env)

  }
}
resource "aws_security_group" "axyya-security-group2" {
  vpc_id = aws_vpc.axyya-vpc.id
  name   = var.aws_sg2_in_var[0]
  ingress {
    description     = var.aws_sg2_in_var[1]
    from_port       = 3000
    to_port         = 3000
    protocol        = var.aws_sg2_in_var[2]
    security_groups = [aws_security_group.axyya-security-group1.id]
  }
  egress {
    description = var.aws_sg_out_var[0]
    from_port   = 0
    to_port     = 0
    protocol    = var.aws_sg_out_var[1]
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-%s", var.aws_sg2_in_var[0], var.env)

  }
}

