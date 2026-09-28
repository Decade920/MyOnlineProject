output "kubeconfig" {
  value     = tencentcloud_kubernetes_cluster_endpoint.main.kube_config
  sensitive = true
}

output "cluster_id" {
  value = tencentcloud_kubernetes_cluster.main.id
}
