output "vpc_id" {
  value = tencentcloud_vpc.main.id
}

output "subnet_id" {
  value = tencentcloud_subnet.public.id
}

output "security_group_id" {
  value = tencentcloud_security_group.web.id
}

output "instance_id" {
  value = tencentcloud_instance.public.id
}

output "public_ip" {
  value = tencentcloud_instance.public.public_ip
}