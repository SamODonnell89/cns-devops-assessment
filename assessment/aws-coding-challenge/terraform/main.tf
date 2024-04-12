
resource "aws_instance" "web_server" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  # Uncomment for SSM
  # iam_instance_profile = aws_iam_instance_profile.main.name

  vpc_security_group_ids      = [aws_security_group.main.id]
  user_data                   = file("${path.module}/user_data/current_time.sh")
  subnet_id                   = aws_subnet.default.id

  tags = {
      Name = join("-", ["web_server", var.env, var.app])
      env  = var.env
      app  = var.app
  }
}

resource "local_file" "public_ip_file" {
  content  = aws_instance.web_server.public_ip
  filename = "public_ip.txt"
}

# Uncomment for SSM
# resource "aws_iam_instance_profile" "main" {
#   name = join("-", ["instance_role", var.env, var.app])
#   role = aws_iam_role.dev_profile.name
# }

# resource "aws_iam_role" "dev_profile" {
#   name = join("-", [var.env, var.app, "role"])

# Required so that we can Connect via SSM
#   managed_policy_arns = [
#     "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   ]

#   max_session_duration = 28800

#   assume_role_policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Action" : "sts:AssumeRole",
#           "Principal" : {
#             "Service" : "ec2.amazonaws.com"
#           },
#           "Effect" : "Allow",
#           "Sid" : ""
#         }
#       ]
#     }
#   )
# }