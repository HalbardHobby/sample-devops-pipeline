variable "cluster_name" {
  description = "Name for the cluster"
  type = string
  default = "Simple_EKS_Cluster"
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type = string
  default = "32.16.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets inside the VPC"
  type = set(string)
  default = [ "32.16.1.0/24", "32.16.2.0/24", "32.16.3.0/24" ]
}

variable "private_subnets" {
  description = "List of private subnets inside the VPC"
  type = set(string)
  default = [ "32.16.4.0/24", "32.16.5.0/24", "32.16.6.0/24" ]
}
