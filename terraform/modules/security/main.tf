resource "aws_security_group" "main" {
  name        = "ecs-sg"
  description = "Allow HTTP traffic to the Medusa application"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Medusa-sg"
  }
}
resource "aws_security_group" "rds" {
  name        = "medusa-rds-sg"
  description = "Allow ECS access to RDS"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Medusa-rds-sg"
  }
}

resource "aws_security_group_rule" "allow_ecs_to_rds" {
  type                     = "ingress"
  from_port               = 5432
  to_port                 = 5432
  protocol                = "tcp"
  security_group_id       = aws_security_group.rds.id
  source_security_group_id = aws_security_group.main.id
}
