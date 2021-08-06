output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "kubectl_config" {
  value = module.eks.kubeconfig
}

output "region" {
  value = var.region
}

output "cluster_name" {
  value = var.cluster_name
}
