resource "tencentcloud_vpc" "main" {
  name       = "tf-tencentcloud-vpc-demo"
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "main_vpc"
  }
}

data "tencentcloud_availability_zones_by_product" "available" {
  product = "cvm"
}

data "tencentcloud_instance_types" "sa2" {
  availability_zone = data.tencentcloud_availability_zones_by_product.available.zones.0.name
  cpu_core_count    = 2
  memory_size       = 2
}

resource "tencentcloud_subnet" "public" {
  vpc_id            = tencentcloud_vpc.main.id
  name              = "tf-tencentcloud-subnet-demo"
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.tencentcloud_availability_zones_by_product.available.zones.0.name

  tags = {
    Name = "main_subnet"
  }
}

resource "tencentcloud_security_group" "web" {
  name        = "tencentcloud-security-group-web"
  description = "Allow HTTP and SSH"
}

resource "tencentcloud_security_group_rule" "web_http" {
  security_group_id = tencentcloud_security_group.web.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "80,443"
  description       = "HTTP/HTTPS"
  policy            = "accept"

}

resource "tencentcloud_security_group_rule" "web_ssh" {
  security_group_id = tencentcloud_security_group.web.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "tcp"
  port_range        = "22"
  description       = "SSH"
  policy            = "accept"
}

data "tencentcloud_images" "my_images" {
  image_type = ["PUBLIC_IMAGE"]
  os_name    = "Ubuntu Server 22.04 LTS 64bit"
}

resource "tencentcloud_instance" "public" {
  availability_zone          = data.tencentcloud_availability_zones_by_product.available.zones.0.name
  instance_name              = "tf-demo-cvm"
  instance_type              = data.tencentcloud_instance_types.sa2.instance_types.0.instance_type
  image_id                   = data.tencentcloud_images.my_images.images.0.image_id
  instance_charge_type       = "POSTPAID_BY_HOUR"
  vpc_id                     = tencentcloud_vpc.main.id
  subnet_id                  = tencentcloud_subnet.public.id
  allocate_public_ip         = true
  internet_max_bandwidth_out = 10
  orderly_security_groups    = [tencentcloud_security_group.web.id]
}
