variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

# variable "instance_type" {
#   type    = string
#   default = "SA9.MEDIUM2"
# }

# variable "availability_zone" {
#   type    = string
#   default = "ap-guangzhou-5"
# }

variable "ingress_rules" {
  type = map(object({
    ports       = list(string)
    description = string
  }))
  default = {
    ssh = {
      ports       = ["22"]
      description = "SSH"
    }
    web = {
      ports       = ["80", "443"]
      description = "HTTP/HTTPS"
    }
  }
}

variable "env_name" {
  type        = string
  description = "dev/prod"
}
