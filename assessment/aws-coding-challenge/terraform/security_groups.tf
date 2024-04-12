resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name = "${var.env}-${var.app}-sg"

  revoke_rules_on_delete = true

  tags = {
    Name = join("-", [var.env, var.app])
    env  = var.env
    app  = var.app
  }
}

resource "aws_security_group_rule" "http_ingress" {
  security_group_id = aws_security_group.main.id
  description = "Allow HTTP inbound traffic"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 80
  protocol    = "tcp"
  to_port     = 80
  type        = "ingress"
}

resource "aws_security_group_rule" "all_egress" {
  security_group_id = aws_security_group.main.id
  description = "Allow all outbound traffic"

  cidr_blocks = ["0.0.0.0/0"]
  from_port   = 0
  protocol    = "-1"
  to_port     = 0
  type        = "egress"
}

# Uncomment if we want access via SSM

# resource "aws_security_group_rule" "ssh_ingress" {
#   security_group_id = aws_security_group.main.id
#   description = "Allow SSH inbound traffic"
#
#   cidr_blocks = ["0.0.0.0/0"]
#   from_port   = 22
#   protocol    = "tcp"
#   to_port     = 22
#   type        = "ingress"
# }

# resource "aws_security_group_rule" "https_ingress" {
#  security_group_id = aws_security_group.main.id
#  description = "Allow HTTPS inbound traffic"
#
#  cidr_blocks = ["0.0.0.0/0"]
#  from_port   = 443
#  protocol    = "tcp"
#  to_port     = 443
#  type        = "ingress"
#}