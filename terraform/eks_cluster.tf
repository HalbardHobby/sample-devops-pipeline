resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.private : subnet.id]
  }
}

resource "aws_autoscaling_group" "workers" {
  name = "eks_cluster_autoscaling"
  max_size = 5
  min_size = 2
  health_check_type = "EC2"
  desired_capacity = 3

  launch_template {
    id = aws_launch_template.worker_template.id
    version = "$latest"
  }
}

resource "aws_launch_template" "worker_template" {
  name_prefix = "worker"
  image_id = "ami-0277b52859bac6f4b"
  instance_type = "t2.micro"
}