variable "cluster_name" {
  description = "Name for the cluster"
  type = string
  default = "pipeline-eks-cluster"
}

variable "region" {
  type = string
  default = "us-east-2"
}
