### Note, not working, and not properly separated into different files.
### New to EKS, unfortunately I have run out of time to complete this today.

locals {
  k8s_resource_files = [
    "./resources/k8s/immutable-deployment-new.yaml",
    "./resources/k8s/pod1.yaml",
    "./resources/k8s/secret1.yaml",
    "./resources/k8s/secret2.yaml",
    "./resources/k8s/secret_handler-new.yaml",
    "./resources/k8s/test.yaml"
  ]
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "canstar-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  enabled_cluster_log_types = ["audit", "api", "authenticator","scheduler"]

  vpc_config {
    subnet_ids              = [aws_subnet.main_az1.id, aws_subnet.main_az2.id]
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs = ["0.0.0.0/0"]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "canstar-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.main_az1.id, aws_subnet.main_az2.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [aws_iam_role_policy_attachment.eks_node_policy]
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "null_resource" "deploy_k8s_resources" {
  provisioner "local-exec" {
    command = "./resources/k8s/deploy.sh"
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${aws_eks_cluster.eks_cluster.name}"
  }

  provisioner "local-exec" {
    command = join(" && ", [for file in local.k8s_resource_files : "kubectl apply -f ${file}"])
  }

  depends_on = [aws_eks_cluster.eks_cluster, aws_eks_node_group.node_group]
}

resource "kubernetes_service" "current_time_service" {
  metadata {
    name = "current-time-service"
  }

  spec {
    selector = {
      app = "current-time-pod"
    }

    port {
      port = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }

  depends_on = [null_resource.deploy_pod2]
}

resource "kubernetes_config_map" "current_time_config" {
  metadata {
    name = "current-time-config"
  }

  data = {
    "current_time.sh" = file("${path.module}/user_data/current_time.sh")
  }
}

resource "null_resource" "deploy_pod2" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${path.module}/pod2.yaml"
  }

  depends_on = [aws_eks_cluster.eks_cluster, aws_eks_node_group.node_group]
}

# resource "aws_instance" "web_server" {
#   ami                         = var.ami
#   instance_type               = "t2.micro"
#   associate_public_ip_address = true
#
#   # Uncomment for SSM
#   # iam_instance_profile = aws_iam_instance_profile.main.name
#
#   vpc_security_group_ids      = [aws_security_group.main.id]
#   user_data                   = file("${path.module}/user_data/current_time.sh")
#   subnet_id                   = aws_subnet.default.id
#
#   tags = {
#       Name = join("-", ["web_server", var.env, var.app])
#       env  = var.env
#       app  = var.app
#   }
# }
#
# resource "local_file" "public_ip_file" {
#   content  = aws_instance.web_server.public_ip
#   filename = "public_ip.txt"
# }

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