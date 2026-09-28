module "tencent_infra" {
  source = "../../modules/tencent-infra"

  env_name      = var.env_name
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  ingress_rules = var.ingress_rules
}

module "tke" {
  source = "../../modules/tke"


  vpc_id             = module.tencent_infra.vpc_id
  subnet_ids         = [module.tencent_infra.subnet_id]
  security_group_ids = [module.tencent_infra.security_group_id]

  env_name       = var.env_name
  cluster_name   = "${var.env_name}-tke-cluster"
  node_pool_name = "${var.env_name}-tke-node-pool"
  cvm_password   = var.cvm_password
  cluster_cidr   = var.cluster_cidr
}


output "instance_public_ip" {
  value = module.tencent_infra.public_ip
}

output "vpc_id" {
  value = module.tencent_infra.vpc_id
}

output "cluster_id" {
  value = module.tke.cluster_id
}

output "kubeconfig" {
  value     = module.tke.kubeconfig
  sensitive = true
}