terraform {
  required_providers {
    tencentcloud = {
      source = "tencentcloudstack/tencentcloud"
    }
  }
}

resource "tencentcloud_kubernetes_cluster" "main" {
  vpc_id              = var.vpc_id
  cluster_name        = var.cluster_name
  network_type        = var.network_type
  cluster_cidr        = var.cluster_cidr
  cluster_version     = var.cluster_version
  cluster_deploy_type = "MANAGED_CLUSTER"

  tags = {
    Environment = var.env_name
    ManagedBy   = "terraform"
  }
}

resource "tencentcloud_kubernetes_node_pool" "main" {
  cluster_id               = tencentcloud_kubernetes_cluster.main.id
  name                     = var.node_pool_name
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  max_size                 = var.max_node_size
  min_size                 = var.min_node_size
  delete_keep_instance     = false
  multi_zone_subnet_policy = "PRIORITY"

  node_os = "ubuntu22.04x86_64"

  auto_scaling_config {
    instance_type              = var.cvm_instance_type
    password                   = var.cvm_password
    orderly_security_group_ids = var.security_group_ids
    system_disk_size           = var.system_disk_size
    system_disk_type           = var.system_disk_type
    instance_charge_type       = "POSTPAID_BY_HOUR"
  }

}

resource "tencentcloud_kubernetes_cluster_endpoint" "main" {
  cluster_id                      = tencentcloud_kubernetes_cluster.main.id
  cluster_internet                = true
  cluster_internet_security_group = var.security_group_ids[0]
}