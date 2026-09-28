variable "vpc_id" {
  type        = string
  description = "TencentCloud VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "TencentCloud Subnet ID"
}

variable "security_group_ids" {
  type        = list(string)
  description = "TencentCloud Security Group ID"
}

variable "env_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "network_type" {
  type    = string
  default = "GR"
}

variable "cluster_cidr" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.34.1"
}

variable "max_node_size" {
  type    = number
  default = 4
}

variable "min_node_size" {
  type    = number
  default = 1
}

variable "cvm_instance_type" {
  type    = string
  default = "SA9.MEDIUM2"
}

variable "node_pool_name" {
  type = string
}

variable "cvm_password" {
  type      = string
  sensitive = true
}

variable "system_disk_size" {
  type    = number
  default = 50
}

variable "availability_zone" {
  type    = string
  default = "ap-guangzhou-5"
}

variable "system_disk_type" {
  type    = string
  default = "CLOUD_PREMIUM"
}
