resource "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    subnet_ids = [for subnet in aws_subnet.private : subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSServicePolicy,
    aws_iam_role_policy_attachment.cluster_AmazonEKSVPCResourceControllerPolicy,
  ]
}

resource "aws_autoscaling_group" "workers" {
  name = "eks_cluster_autoscaling"
  max_size = 5
  min_size = 2
  health_check_type = "EC2"
  desired_capacity = 3

  launch_template {
    id = aws_launch_template.worker_template.id
    version = "$Latest"
  }
}

resource "aws_launch_template" "worker_template" {
  name_prefix = "worker"
  image_id = "ami-0277b52859bac6f4b"
  instance_type = "t2.micro"
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.cluster_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSVPCResourceControllerPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_role.name
}
