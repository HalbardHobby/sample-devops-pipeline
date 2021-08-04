resource "aws_iam_role" "cluster_role" {
  name = var.cluster_name

  assume_role_policy = data.aws_iam_policy_document.cluster_assume_role_policy.json
}

data "aws_iam_policy_document" "cluster_assume_role_policy" {
  statement {
    sid = "EKSClusterAssumeRole"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}
