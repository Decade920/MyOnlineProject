module "tencent_infra" {
  source = "../../modules/tencent-infra"

  env_name      = var.env_name
  vpc_cidr      = var.vpc_cidr
  subnet_cidr   = var.subnet_cidr
  ingress_rules = var.ingress_rules
}

output "instance_public_ip" {
  value = module.tencent_infra.public_ip
}

output "vpc_id" {
  value = module.tencent_infra.vpc_id
}
